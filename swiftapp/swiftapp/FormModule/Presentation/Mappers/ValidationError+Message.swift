//
//  ValidationError+Message.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

extension ValidationError {
    var userMessage: String {
        switch self {
        case .empty:
            return "This field is required."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .numberNotDigitsOnly:
            return "Only digits are allowed."
        case .promoCodeTooShort:
            return "Promo code must have at least 3 characters."
        case .promoCodeTooLong:
            return "Promo code must have at most 7 characters."
        case .promoCodeInvalidCharacters:
            return "Only uppercase letters and hyphens are allowed."
        case .promoCodeContainsDiacritics:
            return "Accented characters are not allowed."
        case .dateCannotBeMonday:
            return "Delivery date can't be a Monday."
        case .dateCannotBeInTheFuture:
            return "Delivery date can't be in the future."
        }
    }
}
