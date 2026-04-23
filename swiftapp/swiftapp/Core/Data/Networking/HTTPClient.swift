//
//  HTTPClient.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

protocol HTTPClient: Sendable {
    func send<T: Decodable & Sendable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}
