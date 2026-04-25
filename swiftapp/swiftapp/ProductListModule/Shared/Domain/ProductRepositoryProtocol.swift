//
//  ProductRepositoryProtocol.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Combine

protocol ProductRepositoryProtocol: Sendable {
    func productsStream() -> AnyPublisher<[Product], Error>
    func product(withId id: Int) async throws -> Product?
}
