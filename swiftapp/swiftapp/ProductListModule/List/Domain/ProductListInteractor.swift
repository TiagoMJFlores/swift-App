//
//  ProductListInteractor.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Combine
import Dependencies

protocol ProductListInteractorProtocol: Sendable {
    func productsPublisher() -> AnyPublisher<[Product], Error>
    func syncFromAPI() async throws
    func search(query: String, in products: [Product]) -> [Product]
}

final class ProductListInteractor: ProductListInteractorProtocol {

    private var repository: any ProductRepositoryProtocol {
        @Dependency(\.productRepository) var repo
        return repo
    }

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

private enum ProductListInteractorKey: DependencyKey {
    static let liveValue: any ProductListInteractorProtocol = ProductListInteractor()
}

extension DependencyValues {
    var productListInteractor: any ProductListInteractorProtocol {
        get { self[ProductListInteractorKey.self] }
        set { self[ProductListInteractorKey.self] = newValue }
    }
}
