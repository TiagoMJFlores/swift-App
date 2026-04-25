//
//  ProductEntity.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import GRDB

struct ProductEntity: Codable, FetchableRecord, PersistableRecord, Sendable, Hashable {

    static let databaseTableName = "products"

    var id: Int
    var title: String
    var productDescription: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var thumbnail: String?
    var images: [String]

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let title = Column(CodingKeys.title)
        static let productDescription = Column(CodingKeys.productDescription)
        static let price = Column(CodingKeys.price)
        static let discountPercentage = Column(CodingKeys.discountPercentage)
        static let rating = Column(CodingKeys.rating)
        static let stock = Column(CodingKeys.stock)
        static let thumbnail = Column(CodingKeys.thumbnail)
        static let images = Column(CodingKeys.images)
    }
}
