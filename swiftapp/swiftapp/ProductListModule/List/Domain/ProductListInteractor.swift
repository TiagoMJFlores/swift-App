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
    func productsPublisher() -> AnyPublisher<[Product], Error>
    func syncFromAPI() async throws
    func search(query: String, in products: [Product]) -> [Product]
}

final class ProductListInteractor: ProductListInteractorProtocol {

    @Injected private var repository: ProductRepositoryProtocol

    func productsPublisher() -> AnyPublisher<[Product], Error> {
        repository.productsPublisher()
    }

    func syncFromAPI() async throws {
        try await repository.syncFromAPI()
    }

    func search(query: String, in products: [Product]) -> [Product] {
        SearchProductsWorker.filter(products, query: query)
    }
}
