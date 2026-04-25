//
//  FormValidators.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

enum FormValidators {

    static func validateName(_ name: String) -> ValidationError? {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .empty : nil
    }

    static func validateEmail(_ email: String) -> ValidationError? {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return .empty }
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return trimmed.range(of: pattern, options: .regularExpression) == nil
            ? .invalidEmail
            : nil
    }

    static func validateNumber(_ number: String) -> ValidationError? {
        if number.isEmpty { return .empty }
        return number.allSatisfy(\.isNumber) ? nil : .numberNotDigitsOnly
    }

    static func validatePromoCode(_ code: String) -> ValidationError? {
        if code.isEmpty { return .empty }
        if code.count < 3 { return .promoCodeTooShort }
        if code.count > 7 { return .promoCodeTooLong }
        if code.unicodeScalars.contains(where: { !isAllowedPromoScalar($0) }) {
            return .promoCodeInvalidCharacters
        }
        if hasDiacritics(code) { return .promoCodeContainsDiacritics }
        return nil
    }

    static func validateDate(_ date: Date, calendar: Calendar = .current, now: Date = .now) -> ValidationError? {
        if date > now { return .dateCannotBeInTheFuture }
        if calendar.component(.weekday, from: date) == 2 { return .dateCannotBeMonday }
        return nil
    }

    static func validateRating(_ rating: Rating?) -> ValidationError? {
        rating == nil ? .empty : nil
    }

    // MARK: - Helpers

    private static func isAllowedPromoScalar(_ scalar: Unicode.Scalar) -> Bool {
        scalar == "-" || (scalar.value >= 0x41 && scalar.value <= 0x5A) // A–Z
    }

    private static func hasDiacritics(_ string: String) -> Bool {
        let folded = string.folding(options: .diacriticInsensitive, locale: .current)
        return folded != string
    }
}
