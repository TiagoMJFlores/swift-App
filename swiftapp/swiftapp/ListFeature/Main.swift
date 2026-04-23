//
//  Main.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

@main
struct Main: App {

    private let viewModel: ListViewModel

    init() {
        let httpClient = URLSessionHTTPClient()
        let repository = ProductRepositoryImpl(httpClient: httpClient)
        self.viewModel = ListViewModel(repository: repository)
    }

    var body: some Scene {
        WindowGroup {
            ListView(viewModel: viewModel)
        }
    }
}
