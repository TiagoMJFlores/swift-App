//
//  FormFeatureDependencies.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Resolver

enum FormFeatureDependencies {
    static func register() {
        Resolver.registerCoreDependencies()
    }
}
