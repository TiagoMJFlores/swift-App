//
//  ProductViewItem.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

struct ProductViewItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let formattedRating: String
    let ratingIconName: String
    let thumbnail: URL?
}
