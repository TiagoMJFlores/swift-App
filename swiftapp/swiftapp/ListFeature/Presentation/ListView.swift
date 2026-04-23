//
//  ListView.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

private enum Strings {
    static let navigationTitle = "Products"
    static let failureTitle = "Could not load products"
}

private enum Icons {
    static let failure = "exclamationmark.triangle"
    static let imagePlaceholder = "photo"
}

struct ListView: View {
    @State private var viewModel: ListViewModel

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

private struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: product.thumbnail) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: Icons.imagePlaceholder)
                        .foregroundStyle(.secondary)
                @unknown default:
                    Color.gray.opacity(0.1)
                }
            }
            .frame(width: 56, height: 56)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image(systemName: product.ratingCategory.iconName)
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    Text(product.rating, format: .number.precision(.fractionLength(2)))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
