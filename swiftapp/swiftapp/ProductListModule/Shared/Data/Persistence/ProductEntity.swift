//
//  ProductEntity.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import SwiftData

@Model
final class ProductEntity {
    @Attribute(.unique) var id: Int
    var title: String
    var productDescription: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var thumbnail: String?
    var images: [String]

    init(
        id: Int,
        title: String,
        productDescription: String,
        price: Double,
        discountPercentage: Double,
        rating: Double,
        stock: Int,
        thumbnail: String?,
        images: [String]
    ) {
        self.id = id
        self.title = title
        self.productDescription = productDescription
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.thumbnail = thumbnail
        self.images = images
    }
}
