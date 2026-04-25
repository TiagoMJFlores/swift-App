//
//  ProductEntity+Domain.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

extension ProductEntity {
    init(from product: Product) {
        self.init(
            id: product.id,
            title: product.title,
            productDescription: product.description,
            price: product.price,
            discountPercentage: product.discountPercentage,
            rating: product.rating,
            stock: product.stock,
            thumbnail: product.thumbnail?.absoluteString,
            images: product.images.map { $0.absoluteString }
        )
    }

    func toDomain() -> Product {
        Product(
            id: id,
            title: title,
            description: productDescription,
            price: price,
            discountPercentage: discountPercentage,
            rating: rating,
            stock: stock,
            thumbnail: thumbnail.flatMap(URL.init(string:)),
            images: images.compactMap(URL.init(string:))
        )
    }
}
