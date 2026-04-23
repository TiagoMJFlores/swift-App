//
//  ProductDetailView.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Resolver

struct ProductDetailView: View {

    private enum Strings {
        static let priceLabel = "Price"
        static let discountLabel = "Discount"
        static let stockLabel = "Stock"
        static let ratingLabel = "Rating"
        static let failureTitle = "Could not open product"
    }

    private enum Icons {
        static let failure = "exclamationmark.triangle"
    }

    private enum Layout {
        static let sectionSpacing: CGFloat = 16
        static let rowSpacing: CGFloat = 8
        static let contentPadding: CGFloat = 20
        static let imageBaseHeight: CGFloat = 320
        static let imageMinHeight: CGFloat = 120
    }

    let productId: Int

    @State private var viewModel: ProductDetailViewModel
    @State private var scrollOffset: CGFloat = 0

    init(productId: Int) {
        self.productId = productId
        _viewModel = State(wrappedValue: Resolver.resolve())
    }

    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if case .idle = viewModel.state {
                    viewModel.load(productId: productId)
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let item):
            loadedContent(item: item)

        case .failed(let message):
            ContentUnavailableView(
                Strings.failureTitle,
                systemImage: Icons.failure,
                description: Text(message)
            )
        }
    }

    private func loadedContent(item: ProductDetailViewItem) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                StretchHeaderImage(
                    url: item.imageURL,
                    scrollOffset: scrollOffset,
                    baseHeight: Layout.imageBaseHeight,
                    minHeight: Layout.imageMinHeight
                )

                VStack(alignment: .leading, spacing: Layout.sectionSpacing) {
                    Text(item.title)
                        .font(.title2)
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: Layout.rowSpacing) {
                        LabelledRow(label: Strings.priceLabel, value: item.formattedPrice)
                        LabelledRow(label: Strings.discountLabel, value: item.formattedDiscount)
                        LabelledRow(label: Strings.stockLabel, value: item.formattedStock)
                        RatingRow(
                            label: Strings.ratingLabel,
                            iconName: item.ratingIconName,
                            value: item.formattedRating
                        )
                    }
                }
                .padding(Layout.contentPadding)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            geometry.contentOffset.y + geometry.contentInsets.top
        } action: { _, newValue in
            scrollOffset = newValue
        }
    }
}
