//
//  FormInteractor.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Dependencies

protocol FormInteractorProtocol: Sendable {
    func submit(_ submission: FormSubmission) throws
}

final class FormInteractor: FormInteractorProtocol {

    func submit(_ submission: FormSubmission) throws {

    }
}

private enum FormInteractorKey: DependencyKey {
    static let liveValue: any FormInteractorProtocol = FormInteractor()
}

extension DependencyValues {
    var formInteractor: any FormInteractorProtocol {
        get { self[FormInteractorKey.self] }
        set { self[FormInteractorKey.self] = newValue }
    }
}
