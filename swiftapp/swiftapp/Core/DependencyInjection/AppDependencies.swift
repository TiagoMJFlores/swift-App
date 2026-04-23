//
//  AppDependencies.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
        registerCoreDependencies()
        registerListFeatureDependencies()
    }
}
