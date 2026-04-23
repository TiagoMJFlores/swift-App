//
//  Product.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

struct Product: Identifiable, Hashable, Sendable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let thumbnail: URL?
    let images: [URL]
}

extension Product {
    enum RatingCategory {
        case low
        case medium
        case high     
    }

    var ratingCategory: RatingCategory {
        switch rating {
        case ..<3:    return .low
        case 3...4:   return .medium
        default:      return .high
        }
    }
}
