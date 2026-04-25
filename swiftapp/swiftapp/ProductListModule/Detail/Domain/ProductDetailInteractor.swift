//
//  ProductDetailInteractor.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Dependencies

protocol ProductDetailInteractorProtocol: Sendable {
    func loadProduct(id: Int) async throws -> Product?
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {

    private var repository: any ProductRepositoryProtocol {
        @Dependency(\.productRepository) var repo
        return repo
    }

    func loadProduct(id: Int) async throws -> Product? {
        try await repository.product(withId: id)
    }
}

private enum ProductDetailInteractorKey: DependencyKey {
    static let liveValue: any ProductDetailInteractorProtocol = ProductDetailInteractor()
}

extension DependencyValues {
    var productDetailInteractor: any ProductDetailInteractorProtocol {
        get { self[ProductDetailInteractorKey.self] }
        set { self[ProductDetailInteractorKey.self] = newValue }
    }
}
