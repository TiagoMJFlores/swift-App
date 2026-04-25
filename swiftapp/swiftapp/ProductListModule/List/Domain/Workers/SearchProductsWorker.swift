//
//  SearchProductsWorker.swift
//  swiftapp
//
//  Created by Tiago Flores on 25/04/2026.
//

import Foundation

enum SearchProductsWorker {

    static func matches(_ product: Product, query: String) -> Bool {
        let tokens = tokens(from: query)
        guard !tokens.isEmpty else { return true }

        let haystack = normalize(product.title) + " " + normalize(product.description)
        return tokens.allSatisfy { haystack.contains($0) }
    }

    static func filter(_ products: [Product], query: String) -> [Product] {
        let tokens = tokens(from: query)
        guard !tokens.isEmpty else { return products }

        return products.filter { product in
            let haystack = normalize(product.title) + " " + normalize(product.description)
            return tokens.allSatisfy { haystack.contains($0) }
        }
    }

    private static func tokens(from query: String) -> [String] {
        normalize(query)
            .split(whereSeparator: { $0.isWhitespace })
            .map(String.init)
    }

    private static func normalize(_ string: String) -> String {
        string
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
    }
}
