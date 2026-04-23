//
//  Product+DetailViewItem.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

extension Product {
    func toDetailViewItem() -> ProductDetailViewItem {
        ProductDetailViewItem(
            id: id,
            title: title,
            formattedPrice: price.formatted(.currency(code: "USD")),
            formattedDiscount: (discountPercentage / 100)
                .formatted(.percent.precision(.fractionLength(0...1))),
            formattedStock: "\(stock) in stock",
            formattedRating: rating.formatted(.number.precision(.fractionLength(2))),
            ratingIconName: ratingCategory.iconName,
            thumbnail: thumbnail
        )
    }
}
