//
//  DatabaseProvider.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import GRDB

enum DatabaseProvider {

    private static let databaseFileName = "swiftapp.sqlite"

    static let shared: DatabaseQueue = {
        do {
            let url = try storeURL()
            let queue = try DatabaseQueue(path: url.path)
            try setupSchema(queue)
            return queue
        } catch {
            fatalError("Failed to create DatabaseQueue: \(error)")
        }
    }()

    private static func storeURL() throws -> URL {
        let directory = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        return directory.appendingPathComponent(databaseFileName)
    }

    private static func setupSchema(_ queue: DatabaseQueue) throws {
        try queue.write { db in
            try db.create(table: ProductEntity.databaseTableName, ifNotExists: true) { t in
                t.column(ProductEntity.Columns.id.name, .integer).primaryKey()
                t.column(ProductEntity.Columns.title.name, .text).notNull()
                t.column(ProductEntity.Columns.productDescription.name, .text).notNull()
                t.column(ProductEntity.Columns.price.name, .double).notNull()
                t.column(ProductEntity.Columns.discountPercentage.name, .double).notNull()
                t.column(ProductEntity.Columns.rating.name, .double).notNull()
                t.column(ProductEntity.Columns.stock.name, .integer).notNull()
                t.column(ProductEntity.Columns.thumbnail.name, .text)
                t.column(ProductEntity.Columns.images.name, .text).notNull()
            }

            try db.create(table: SyncState.databaseTableName, ifNotExists: true) { t in
                t.column(SyncState.Columns.id.name, .integer).primaryKey()
                t.column(SyncState.Columns.totalExpected.name, .integer).notNull()
                t.column(SyncState.Columns.totalDownloaded.name, .integer).notNull()
                t.column(SyncState.Columns.completedAt.name, .datetime)
            }
        }
    }
}
