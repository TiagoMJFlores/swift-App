//
//  ListFeatureDependencies.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

enum ListFeatureDependencies {
    static func register() {
        Resolver.registerCoreDependencies()

        Resolver.register { ProductRepository() }
            .implements(ProductRepositoryProtocol.self)
            .scope(.application)

        Resolver.register { ProductListInteractor() }
            .implements(ProductListInteractorProtocol.self)

        Resolver.register { ProductListViewModel() }
    }
}
