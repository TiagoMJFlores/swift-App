//
//  FormViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Combine
import Dependencies

@MainActor
final class FormViewModel: ObservableObject {

    enum SubmitState: Equatable {
        case idle
        case submitting
        case succeeded
        case failed(String)
    }

    @Published var formInput = FormInput()
    @Published private(set) var errors = FormErrors()
    @Published private(set) var isSubmitEnabled = false
    @Published private(set) var submitState: SubmitState = .idle

    @Dependency(\.formValidator) private var validator
    @Dependency(\.formInteractor) private var interactor

    private var cancellables = Set<AnyCancellable>()

    init() {
        bindValidation()
    }

    private func bindValidation() {
        $formInput
            .map { [validator] input in validator.validate(input) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errors in
                self?.errors = errors
                self?.isSubmitEnabled = errors.isEmpty
            }
            .store(in: &cancellables)
    }

    func submit() {
        guard isSubmitEnabled, let rating = formInput.rating else { return }
        let submission = FormSubmission(
            name: formInput.name,
            email: formInput.email,
            number: formInput.number,
            promoCode: formInput.promoCode,
            deliveryDate: formInput.deliveryDate,
            rating: rating
        )
        submitState = .submitting
        do {
            try interactor.submit(submission)
            submitState = .succeeded
        } catch {
            submitState = .failed(error.localizedDescription)
        }
    }

    func reset() {
        formInput = FormInput()
        submitState = .idle
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
