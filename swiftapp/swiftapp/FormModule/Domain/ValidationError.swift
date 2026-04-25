//
//  ValidationError.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

enum ValidationError: Equatable, Sendable {
    case empty
    case invalidEmail
    case numberNotDigitsOnly
    case promoCodeTooShort
    case promoCodeTooLong
    case promoCodeInvalidCharacters
    case promoCodeContainsDiacritics
    case dateCannotBeMonday
    case dateCannotBeInTheFuture
}
