//
//  DatabaseProvider.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import GRDB

enum DatabaseProvider {

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
        return directory.appendingPathComponent("swiftapp.sqlite")
    }

    private static func setupSchema(_ queue: DatabaseQueue) throws {
        try queue.write { db in
            try db.create(table: "products", ifNotExists: true) { t in
                t.column("id", .integer).primaryKey()
                t.column("title", .text).notNull()
                t.column("productDescription", .text).notNull()
                t.column("price", .double).notNull()
                t.column("discountPercentage", .double).notNull()
                t.column("rating", .double).notNull()
                t.column("stock", .integer).notNull()
                t.column("thumbnail", .text)
                t.column("images", .text).notNull()
            }

            try db.create(table: "sync_state", ifNotExists: true) { t in
                t.column("id", .integer).primaryKey()
                t.column("totalExpected", .integer).notNull()
                t.column("totalDownloaded", .integer).notNull()
                t.column("completedAt", .datetime)
            }
        }
    }
}
