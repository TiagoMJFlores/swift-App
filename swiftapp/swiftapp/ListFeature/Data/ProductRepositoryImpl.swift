//
//  ProductRepositoryImpl.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

final class ProductRepositoryImpl: ProductRepository {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func fetchProducts(limit: Int, skip: Int) async throws -> [Product] {
        let response = try await httpClient.send(
            ProductsEndpoint.list(limit: limit, skip: skip),
            as: ProductsResponseDTO.self
        )
        return response.products.map { $0.toDomain() }
    }
}
