//
//  ProductDetailViewItem.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

struct ProductDetailViewItem: Hashable, Sendable {
    let id: Int
    let title: String
    let formattedPrice: String
    let formattedDiscount: String
    let formattedStock: String
    let formattedRating: String
    let ratingIconName: String
    let imageURL: URL?
}
