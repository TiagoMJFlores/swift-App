//
//  PersistenceContainer.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import SwiftData

enum PersistenceContainer {
    static let shared: ModelContainer = {
        do {
            return try ModelContainer(for: ProductEntity.self, SyncState.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}
