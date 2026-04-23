//
//  RatingCategory+Icon.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

extension Product.RatingCategory {
    var iconName: String {
        switch self {
        case .low:    return "star"
        case .medium: return "star.leadinghalf.filled"
        case .high:   return "star.fill"
        }
    }
}
