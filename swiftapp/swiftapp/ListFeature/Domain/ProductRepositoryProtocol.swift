//
//  ProductRepositoryProtocol.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

protocol ProductRepositoryProtocol {
    func productsStream() -> AsyncThrowingStream<[Product], Error>
}
