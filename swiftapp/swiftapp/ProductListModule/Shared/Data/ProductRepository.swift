//
//  ProductRepository.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
@preconcurrency import Combine
import Dependencies

final class ProductRepository: ProductRepositoryProtocol {

    private let pageSize: Int

    init(pageSize: Int = 30) {
        self.pageSize = pageSize
    }

    private var httpClient: any HTTPClientProtocol {
        @Dependency(\.httpClient) var http
        return http
    }

    private var localDataSource: any ProductLocalDataSourceProtocol {
        @Dependency(\.productLocalDataSource) var local
        return local
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

private enum ProductRepositoryKey: DependencyKey {
    static let liveValue: any ProductRepositoryProtocol = ProductRepository()
}

extension DependencyValues {
    var productRepository: any ProductRepositoryProtocol {
        get { self[ProductRepositoryKey.self] }
        set { self[ProductRepositoryKey.self] = newValue }
    }
}
