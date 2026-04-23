//
//  ProductListView.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Resolver

struct ProductListView: View {
    @State private var viewModel: ProductListViewModel

    private enum Strings {
        static let navigationTitle = "Products"
        static let failureTitle = "Could not load products"
    }

    private enum Icons {
        static let failure = "exclamationmark.triangle"
    }

    init() {
        _viewModel = State(wrappedValue: Resolver.resolve())
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(Strings.navigationTitle)
                .navigationDestination(for: Int.self) { productId in
                    ProductDetailView(productId: productId)
                }
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

        case .loaded(let items):
            List(items) { item in
                NavigationLink(value: item.id) {
                    ProductRow(item: item)
                }
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
