//
//  FormSubmission.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation

struct FormSubmission: Hashable, Sendable {
    let name: String
    let email: String
    let number: String
    let promoCode: String
    let deliveryDate: Date
    let rating: Rating
}
