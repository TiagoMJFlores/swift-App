//
//  ListFeatureDependencies.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

extension Resolver {
    static func registerListFeatureDependencies() {
        // Data
        register { ProductRepository() }
            .implements(ProductRepositoryProtocol.self)
            .scope(.application)

        // Domain
        register { ProductListInteractor() }
            .implements(ProductListInteractorProtocol.self)

        // Presentation
        register { ProductListViewModel() }
    }
}
