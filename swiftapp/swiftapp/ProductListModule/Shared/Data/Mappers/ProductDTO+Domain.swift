//
//  ProductDTO+Domain.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

extension ProductDTO {
    func toDomain() -> Product {
        Product(
            id: id,
            title: title,
            description: description,
            price: price,
            discountPercentage: discountPercentage,
            rating: rating,
            stock: stock,
            thumbnail: thumbnail.flatMap(URL.init(string:)),
            images: (images ?? []).compactMap(URL.init(string:))
        )
    }
}
