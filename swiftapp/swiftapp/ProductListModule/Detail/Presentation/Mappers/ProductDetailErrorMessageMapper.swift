//
//  ProductDetailErrorMessageMapper.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

enum ProductDetailErrorMessageMapper {
    case loadProduct(Error)
    case notFound

    var userMessage: String {
        switch self {
        case .loadProduct(let error):
            if let generic = Self.baseMapper.genericMessage(for: error) {
                return generic
            }
            return "We couldn't open this product right now. Please try again."
        case .notFound:
            return "We couldn't find this product."
        }
    }

    private static let baseMapper = ErrorMessageMapper()
}
