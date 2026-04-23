//
//  ProductsEndpoint.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

enum ProductsEndpoint: Endpoint {
    case list(limit: Int, skip: Int)

    var path: String {
        switch self {
        case .list: return "/products"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .list(let limit, let skip):
            return [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "skip", value: String(skip))
            ]
        }
    }
}
