//
//  ProductRepository.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

final class ProductRepository: ProductRepositoryProtocol {

    @Injected private var httpClient: HTTPClientProtocol

    func fetchProducts(limit: Int, skip: Int) async throws -> [Product] {
        let response = try await httpClient.send(
            ProductsEndpoint.list(limit: limit, skip: skip),
            as: ProductsResponseDTO.self
        )
        return response.products.map { $0.toDomain() }
    }
}
