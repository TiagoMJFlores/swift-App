//
//  Main.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Resolver

@main
struct Main: App {

    init() {
        Resolver.registerAllServices()
    }

    var body: some Scene {
        WindowGroup {
            ProductListView(viewModel: Resolver.resolve())
        }
    }
}
