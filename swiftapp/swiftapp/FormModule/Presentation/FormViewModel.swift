//
//  FormViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Observation
import Dependencies

@MainActor
@Observable
final class FormViewModel {

    // MARK: - Inputs

    var name = ""
    var email = ""
    var number = ""
    var promoCode = ""
    var deliveryDate = Date()
    var rating: Rating?

    private(set) var didSubmit = false

    @ObservationIgnored
    @Dependency(\.formInteractor) private var interactor

    // MARK: - Derived validation state

    var nameError: ValidationError?   { FormValidators.validateName(name) }
    var emailError: ValidationError?  { FormValidators.validateEmail(email) }
    var numberError: ValidationError? { FormValidators.validateNumber(number) }
    var promoError: ValidationError?  { FormValidators.validatePromoCode(promoCode) }
    var dateError: ValidationError?   { FormValidators.validateDate(deliveryDate) }
    var ratingError: ValidationError? { FormValidators.validateRating(rating) }

    var isFormValid: Bool {
        nameError == nil
            && emailError == nil
            && numberError == nil
            && promoError == nil
            && dateError == nil
            && ratingError == nil
    }

    // MARK: - Actions

    func submit() {
        guard isFormValid, let rating else { return }
        let submission = FormSubmission(
            name: name,
            email: email,
            number: number,
            promoCode: promoCode,
            deliveryDate: deliveryDate,
            rating: rating
        )
        do {
            try interactor.submit(submission)
            didSubmit = true
        } catch {
            // do later
        }
    }

    func reset() {
        name = ""
        email = ""
        number = ""
        promoCode = ""
        deliveryDate = Date()
        rating = nil
        didSubmit = false
    }
}

private enum FormViewModelKey: DependencyKey {
    static let liveValue: @MainActor () -> FormViewModel = {
        FormViewModel()
    }
}

extension DependencyValues {
    var makeFormViewModel: @MainActor () -> FormViewModel {
        get { self[FormViewModelKey.self] }
        set { self[FormViewModelKey.self] = newValue }
    }
}
