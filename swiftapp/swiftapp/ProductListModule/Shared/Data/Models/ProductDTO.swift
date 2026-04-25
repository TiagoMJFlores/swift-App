//
//  ProductDTO.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

struct ProductDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let thumbnail: String?
    let images: [String]?
}

struct ProductsResponseDTO: Decodable {
    let products: [ProductDTO]
    let total: Int
    let skip: Int
    let limit: Int
}
