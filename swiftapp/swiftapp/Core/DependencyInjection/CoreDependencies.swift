//
//  CoreDependencies.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

extension Resolver {
    static func registerCoreDependencies() {
        register { URLSessionHTTPClient() }
            .implements(HTTPClientProtocol.self)
            .scope(.application)
    }
}
