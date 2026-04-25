//
//  ProductRepository.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
@preconcurrency import Combine
import Resolver

nonisolated final class ProductRepository: ProductRepositoryProtocol {

    private let httpClient: HTTPClientProtocol
    private let localDataSource: ProductLocalDataSourceProtocol
    private let pageSize: Int

    init(
        httpClient: HTTPClientProtocol = Resolver.resolve(),
        localDataSource: ProductLocalDataSourceProtocol = Resolver.resolve(),
        pageSize: Int = 30
    ) {
        self.httpClient = httpClient
        self.localDataSource = localDataSource
        self.pageSize = pageSize
    }

    func product(withId id: Int) async throws -> Product? {
        try await localDataSource.product(withId: id)
    }

    func productsStream() -> AnyPublisher<[Product], Error> {
        let subject = PassthroughSubject<[Product], Error>()

        let task = Task { [httpClient, localDataSource, pageSize] in
            do {
                let syncState = try await localDataSource.loadSyncState()
                var accumulated = try await localDataSource.allProducts()

                subject.send(accumulated)

                if syncState?.isComplete == true {
                    subject.send(completion: .finished)
                    return
                }

                var downloaded = syncState?.totalDownloaded ?? 0
                var total = syncState?.totalExpected ?? Int.max

                while downloaded < total {
                    try Task.checkCancellation()

                    let response = try await httpClient.send(
                        ProductsEndpoint.list(limit: pageSize, skip: downloaded),
                        as: ProductsResponseDTO.self
                    )
                    let pageProducts = response.products.map { $0.toDomain() }
                    try await localDataSource.save(pageProducts)

                    accumulated.append(contentsOf: pageProducts)
                    total = response.total
                    downloaded += pageProducts.count

                    try await localDataSource.saveSyncState(SyncStateSnapshot(
                        totalExpected: total,
                        totalDownloaded: downloaded,
                        completedAt: downloaded >= total ? .now : nil
                    ))

                    subject.send(accumulated)
                }

                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }

        return subject
            .handleEvents(receiveCancel: { task.cancel() })
            .eraseToAnyPublisher()
    }
}
