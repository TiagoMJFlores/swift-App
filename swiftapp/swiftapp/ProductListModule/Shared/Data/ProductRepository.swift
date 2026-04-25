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

    func productsPublisher() -> AnyPublisher<[Product], Error> {
        localDataSource.productsPublisher()
    }

    func product(withId id: Int) async throws -> Product? {
        try await localDataSource.product(withId: id)
    }

    func syncFromAPI() async throws {
        let syncState = try await localDataSource.loadSyncState()
        if syncState?.isComplete == true { return }

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

            total = response.total
            downloaded += pageProducts.count

            try await localDataSource.saveSyncState(SyncStateSnapshot(
                totalExpected: total,
                totalDownloaded: downloaded,
                completedAt: downloaded >= total ? .now : nil
            ))
        }
    }
}
