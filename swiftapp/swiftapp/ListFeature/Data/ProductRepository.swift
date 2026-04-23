//
//  ProductRepository.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

final class ProductRepository: ProductRepositoryProtocol {

    @Injected private var httpClient: HTTPClientProtocol
    @Injected private var localDataSource: ProductLocalDataSourceProtocol

    private let pageSize =  30

    func productsStream() -> AsyncThrowingStream<[Product], Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let syncState = try localDataSource.loadSyncState()
                    var accumulated = try localDataSource.allProducts()

                    continuation.yield(accumulated)

                    if syncState?.isComplete == true {
                        continuation.finish()
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
                        try localDataSource.save(pageProducts)

                        accumulated.append(contentsOf: pageProducts)
                        total = response.total
                        downloaded += pageProducts.count

                        try localDataSource.saveSyncState(SyncStateSnapshot(
                            totalExpected: total,
                            totalDownloaded: downloaded,
                            completedAt: downloaded >= total ? .now : nil
                        ))

                        continuation.yield(accumulated)
                    }

                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }

            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
