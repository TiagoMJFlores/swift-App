//
//  ProductListInteractor.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Combine
import Resolver

protocol ProductListInteractorProtocol {
    func productsStream() -> AnyPublisher<[Product], Error>
    func search(query: String, in products: [Product]) -> [Product]
}

final class ProductListInteractor: ProductListInteractorProtocol {

    @Injected private var repository: ProductRepositoryProtocol

    func productsStream() -> AnyPublisher<[Product], Error> {
        repository.productsStream()
    }

    func search(query: String, in products: [Product]) -> [Product] {
        SearchProductsWorker.filter(products, query: query)
    }
}
