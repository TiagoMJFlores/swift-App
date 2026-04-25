//
//  ProductListView.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Resolver

struct ProductListView: View {

    private enum Strings {
        static let navigationTitle = "Products"
        static let searchPrompt = "Search products"
        static let failureTitle = "Could not load products"
        static let emptySearchTitle = "No products found"
        static let emptySearchMessage = "Try a different search term."
    }

    private enum Icons {
        static let failure = "exclamationmark.triangle"
        static let emptySearch = "magnifyingglass"
    }

    @StateObject private var viewModel: ProductListViewModel

    init() {
        _viewModel = StateObject(wrappedValue: Resolver.resolve())
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(Strings.navigationTitle)
                .searchable(text: $viewModel.searchQuery, prompt: Text(Strings.searchPrompt))
                .navigationDestination(for: Int.self) { productId in
                    ProductDetailView(productId: productId)
                }
        }
        .onAppear {
            if case .idle = viewModel.state {
                viewModel.load()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded:
            loadedContent

        case .failed(let message):
            ContentUnavailableView(
                Strings.failureTitle,
                systemImage: Icons.failure,
                description: Text(message)
            )
        }
    }

    @ViewBuilder
    private var loadedContent: some View {
        let items = viewModel.displayedItems
        if items.isEmpty && !viewModel.searchQuery.isEmpty {
            ContentUnavailableView(
                Strings.emptySearchTitle,
                systemImage: Icons.emptySearch,
                description: Text(Strings.emptySearchMessage)
            )
        } else {
            List(items) { item in
                NavigationLink(value: item.id) {
                    ProductRow(item: item)
                }
            }
            .listStyle(.plain)
        }
    }
}
