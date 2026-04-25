//
//  ProductLocalDataSource.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Combine
import Dependencies
import GRDB

struct SyncStateSnapshot: Sendable {
    let totalExpected: Int
    let totalDownloaded: Int
    let completedAt: Date?

    var isComplete: Bool { completedAt != nil }
}

protocol ProductLocalDataSourceProtocol: Sendable {
    func productsPublisher() -> AnyPublisher<[Product], Error>
    func allProducts() async throws -> [Product]
    func product(withId id: Int) async throws -> Product?
    func save(_ products: [Product]) async throws
    func loadSyncState() async throws -> SyncStateSnapshot?
    func saveSyncState(_ snapshot: SyncStateSnapshot) async throws
}

final class ProductLocalDataSource: ProductLocalDataSourceProtocol {

    private let dbQueue: DatabaseQueue

    init(dbQueue: DatabaseQueue = DatabaseProvider.shared) {
        self.dbQueue = dbQueue
    }

    func productsPublisher() -> AnyPublisher<[Product], Error> {
        ValueObservation
            .tracking { db in
                try ProductEntity
                    .order(ProductEntity.Columns.id)
                    .fetchAll(db)
            }
            .publisher(in: dbQueue)
            .map { entities in entities.map { $0.toDomain() } }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    func allProducts() async throws -> [Product] {
        try await dbQueue.read { db in
            try ProductEntity
                .order(ProductEntity.Columns.id)
                .fetchAll(db)
                .map { $0.toDomain() }
        }
    }

    func product(withId id: Int) async throws -> Product? {
        try await dbQueue.read { db in
            try ProductEntity
                .filter(ProductEntity.Columns.id == id)
                .fetchOne(db)?
                .toDomain()
        }
    }

    func save(_ products: [Product]) async throws {
        try await dbQueue.write { db in
            for product in products {
                try ProductEntity(from: product).insert(db, onConflict: .replace)
            }
        }
    }

    func loadSyncState() async throws -> SyncStateSnapshot? {
        try await dbQueue.read { db in
            guard let state = try SyncState.fetchOne(db, key: SyncState.singletonId) else {
                return nil
            }
            return SyncStateSnapshot(
                totalExpected: state.totalExpected,
                totalDownloaded: state.totalDownloaded,
                completedAt: state.completedAt
            )
        }
    }

    func saveSyncState(_ snapshot: SyncStateSnapshot) async throws {
        try await dbQueue.write { db in
            let state = SyncState(
                totalExpected: snapshot.totalExpected,
                totalDownloaded: snapshot.totalDownloaded,
                completedAt: snapshot.completedAt
            )
            try state.save(db)
        }
    }
}

private enum ProductLocalDataSourceKey: DependencyKey {
    static let liveValue: any ProductLocalDataSourceProtocol = ProductLocalDataSource()
}

extension DependencyValues {
    var productLocalDataSource: any ProductLocalDataSourceProtocol {
        get { self[ProductLocalDataSourceKey.self] }
        set { self[ProductLocalDataSourceKey.self] = newValue }
    }
}
