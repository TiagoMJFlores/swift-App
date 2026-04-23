//
//  Main.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

@main
struct Main: App {

    init() {
        ListFeatureDependencies.register()
    }

    var body: some Scene {
        WindowGroup {
            ProductListView()
        }
    }
}
