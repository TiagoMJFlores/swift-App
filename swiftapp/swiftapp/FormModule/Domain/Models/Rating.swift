//
//  Rating.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

enum Rating: String, CaseIterable, Identifiable, Sendable {
    case bad = "Bad"
    case satisfactory = "Satisfactory"
    case good = "Good"
    case veryGood = "Very Good"
    case excellent = "Excellent"

    var id: String { rawValue }
}
