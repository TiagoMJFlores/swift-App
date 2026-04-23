//
//  ProductListInteractor.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

protocol ProductListInteractorProtocol {
    func loadProducts() async throws -> [Product]
}

final class ProductListInteractor: ProductListInteractorProtocol {

    @Injected private var repository: ProductRepositoryProtocol

    private let pageSize: Int

    init(pageSize: Int = 30) {
        self.pageSize = pageSize
    }

    func loadProducts() async throws -> [Product] {
        try await repository.fetchProducts(limit: pageSize, skip: 0)
    }
}
