//
//  SyncState.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import GRDB

struct SyncState: Codable, FetchableRecord, PersistableRecord, Sendable, Hashable {

    static let databaseTableName = "sync_state"

    static let singletonId: Int = 1

    var id: Int = singletonId
    var totalExpected: Int
    var totalDownloaded: Int
    var completedAt: Date?

    var isComplete: Bool { completedAt != nil }

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let totalExpected = Column(CodingKeys.totalExpected)
        static let totalDownloaded = Column(CodingKeys.totalDownloaded)
        static let completedAt = Column(CodingKeys.completedAt)
    }
}
