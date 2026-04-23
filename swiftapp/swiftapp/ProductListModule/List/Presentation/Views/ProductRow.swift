//
//  ProductRow.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Kingfisher

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
        static let thumbnailFadeDuration: Double = 0.2
    }

    let item: ProductViewItem

    var body: some View {
        HStack(spacing: Layout.rowSpacing) {
            thumbnail
                .frame(width: Layout.thumbnailSize, height: Layout.thumbnailSize)
                .background(Color.gray.opacity(Layout.thumbnailBackgroundOpacity))
                .clipShape(RoundedRectangle(cornerRadius: Layout.thumbnailCornerRadius))

            VStack(alignment: .leading, spacing: Layout.textSpacing) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(Layout.titleLineLimit)

                HStack(spacing: Layout.ratingSpacing) {
                    Image(systemName: item.ratingIconName)
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    Text(item.formattedRating)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, Layout.verticalPadding)
    }

    @ViewBuilder
    private var thumbnail: some View {
        KFImage(item.thumbnail)
            .placeholder { ProgressView() }
            .fade(duration: Layout.thumbnailFadeDuration)
            .cancelOnDisappear(true)
            .resizable()
            .scaledToFill()
    }
}
