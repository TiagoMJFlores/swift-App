//
//  ListView.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI


struct ListView: View {
    @State private var viewModel: ListViewModel
    
    private enum Strings {
        static let navigationTitle = "Products"
        static let failureTitle = "Could not load products"
    }

    private enum Icons {
        static let failure = "exclamationmark.triangle"
    }

    init(viewModel: ListViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(Strings.navigationTitle)
        }
        .task {
            if case .idle = viewModel.state {
                await viewModel.load()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let products):
            List(products) { product in
                ProductRow(product: product)
            }
            .listStyle(.plain)

        case .failed(let message):
            ContentUnavailableView(
                Strings.failureTitle,
                systemImage: Icons.failure,
                description: Text(message)
            )
        }
    }
}
