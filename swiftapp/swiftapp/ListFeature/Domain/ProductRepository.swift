//
//  ProductRepository.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

protocol ProductRepository {
 
    func fetchProducts(limit: Int, skip: Int) async throws -> [Product]
}
