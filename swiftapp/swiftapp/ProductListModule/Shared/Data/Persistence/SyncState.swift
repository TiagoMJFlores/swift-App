//
//  SyncState.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import SwiftData

@Model
final class SyncState {
    var totalExpected: Int
    var totalDownloaded: Int
    var completedAt: Date?

    init(totalExpected: Int, totalDownloaded: Int, completedAt: Date? = nil) {
        self.totalExpected = totalExpected
        self.totalDownloaded = totalDownloaded
        self.completedAt = completedAt
    }

    var isComplete: Bool { completedAt != nil }
}
