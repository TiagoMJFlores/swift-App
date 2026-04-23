//
//  Product+ViewItem.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

extension Product {
    func toViewItem() -> ProductViewItem {
        ProductViewItem(
            id: id,
            title: title,
            formattedRating: rating.formatted(.number.precision(.fractionLength(2))),
            ratingIconName: ratingCategory.iconName,
            thumbnail: thumbnail
        )
    }
}
