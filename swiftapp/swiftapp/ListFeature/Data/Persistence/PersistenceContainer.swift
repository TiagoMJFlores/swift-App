//
//  PersistenceContainer.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import SwiftData

/// Shared SwiftData container. Lazy singleton so it's created once per
/// process and reused across data sources.
enum PersistenceContainer {
    static let shared: ModelContainer = {
        do {
            return try ModelContainer(for: ProductEntity.self, SyncState.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}
