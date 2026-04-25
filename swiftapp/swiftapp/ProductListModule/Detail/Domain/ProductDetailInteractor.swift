//
//  ProductDetailInteractor.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

protocol ProductDetailInteractorProtocol {
    func loadProduct(id: Int) async throws -> Product?
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {

    @Injected private var repository: ProductRepositoryProtocol

    func loadProduct(id: Int) async throws -> Product? {
        try await repository.product(withId: id)
    }
}
