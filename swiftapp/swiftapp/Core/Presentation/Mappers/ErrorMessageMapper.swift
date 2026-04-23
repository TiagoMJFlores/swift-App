//
//  ErrorMessageMapper.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

struct ErrorMessageMapper {

    func genericMessage(for error: Error) -> String? {
        if let network = error as? NetworkError, case .transport = network {
            return "Looks like you're offline. Check your connection and try again."
        }
        return nil
    }
}
