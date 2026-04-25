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
        static let rating = Column(CodingKeys.rating)
    }
}
