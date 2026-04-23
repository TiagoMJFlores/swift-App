//
//  ListErrorMessageMapper.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

enum ListErrorMessageMapper {
    case loadProducts(Error)
    case searchProducts(Error)

    var userMessage: String {
        if let generic = Self.baseMapper.genericMessage(for: underlyingError) {
            return generic
        }
        switch self {
        case .loadProducts:   return "We couldn't load the products right now. Please try again."
        case .searchProducts: return "We couldn't run your search right now. Please try again."
        }
    }

    private var underlyingError: Error {
        switch self {
        case .loadProducts(let error),
             .searchProducts(let error):
            return error
        }
    }

    private static let baseMapper = ErrorMessageMapper()
}
