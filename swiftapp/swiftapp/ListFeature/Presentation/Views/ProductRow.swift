//
//  ProductRow.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//
import SwiftUI

struct ProductRow: View {

    private enum Icons {
        static let imagePlaceholder = "photo"
    }

    private enum Layout {
        static let rowSpacing: CGFloat = 12
        static let thumbnailSize: CGFloat = 56
        static let thumbnailCornerRadius: CGFloat = 8
        static let thumbnailBackgroundOpacity: Double = 0.1
        static let textSpacing: CGFloat = 4
        static let ratingSpacing: CGFloat = 4
        static let verticalPadding: CGFloat = 4
        static let titleLineLimit = 1
        static let ratingFractionDigits = 2
    }

    let product: Product

    var body: some View {
        HStack(spacing: Layout.rowSpacing) {
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
                    Color.gray.opacity(Layout.thumbnailBackgroundOpacity)
                }
            }
            .frame(width: Layout.thumbnailSize, height: Layout.thumbnailSize)
            .background(Color.gray.opacity(Layout.thumbnailBackgroundOpacity))
            .clipShape(RoundedRectangle(cornerRadius: Layout.thumbnailCornerRadius))

            VStack(alignment: .leading, spacing: Layout.textSpacing) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(Layout.titleLineLimit)

                HStack(spacing: Layout.ratingSpacing) {
                    Image(systemName: product.ratingCategory.iconName)
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    Text(product.rating, format: .number.precision(.fractionLength(Layout.ratingFractionDigits)))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, Layout.verticalPadding)
    }
}
