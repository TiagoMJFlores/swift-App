//
//  ProductLocalDataSource.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import SwiftData

struct SyncStateSnapshot: Sendable {
    let totalExpected: Int
    let totalDownloaded: Int
    let completedAt: Date?

    var isComplete: Bool { completedAt != nil }
}

protocol ProductLocalDataSourceProtocol: Sendable {
    func allProducts() async throws -> [Product]
    func product(withId id: Int) async throws -> Product?
    func save(_ products: [Product]) async throws
    func loadSyncState() async throws -> SyncStateSnapshot?
    func saveSyncState(_ snapshot: SyncStateSnapshot) async throws
}

@MainActor
final class ProductLocalDataSource: ProductLocalDataSourceProtocol {

    private let container: ModelContainer

    init(container: ModelContainer = PersistenceContainer.shared) {
        self.container = container
    }

    private var context: ModelContext { container.mainContext }

    func allProducts() throws -> [Product] {
        let descriptor = FetchDescriptor<ProductEntity>(sortBy: [SortDescriptor(\.id)])
        return try context.fetch(descriptor).map { $0.toDomain() }
    }

    func product(withId id: Int) throws -> Product? {
        var descriptor = FetchDescriptor<ProductEntity>(
            predicate: #Predicate { $0.id == id }
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first?.toDomain()
    }

    func save(_ products: [Product]) throws {
        for product in products {
            context.insert(ProductEntity(from: product))
        }
        try context.save()
    }

    func loadSyncState() throws -> SyncStateSnapshot? {
        let descriptor = FetchDescriptor<SyncState>()
        guard let state = try context.fetch(descriptor).first else { return nil }
        return SyncStateSnapshot(
            totalExpected: state.totalExpected,
            totalDownloaded: state.totalDownloaded,
            completedAt: state.completedAt
        )
    }

    func saveSyncState(_ snapshot: SyncStateSnapshot) throws {
        let descriptor = FetchDescriptor<SyncState>()
        if let existing = try context.fetch(descriptor).first {
            existing.totalExpected = snapshot.totalExpected
            existing.totalDownloaded = snapshot.totalDownloaded
            existing.completedAt = snapshot.completedAt
        } else {
            context.insert(SyncState(
                totalExpected: snapshot.totalExpected,
                totalDownloaded: snapshot.totalDownloaded,
                completedAt: snapshot.completedAt
            ))
        }
        try context.save()
    }
}
