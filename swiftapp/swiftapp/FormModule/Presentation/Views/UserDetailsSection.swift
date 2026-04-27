//
//  UserDetailsSection.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct UserDetailsSection: View {

    private enum Strings {
        static let title = "Your details"
        static let nameLabel = "Name"
        static let emailLabel = "Email"
        static let numberLabel = "Number"
    }

    private enum Layout {
        static let fieldErrorSpacing: CGFloat = 4
    }

    @ObservedObject var viewModel: FormViewModel

    var body: some View {
        Section(Strings.title) {
            VStack(alignment: .leading, spacing: Layout.fieldErrorSpacing) {
                FloatingLabelTextField(
                    label: Strings.nameLabel,
                    text: $viewModel.formInput.name,
                    textContentType: .name
                )
                FieldErrorLabel(error: viewModel.errors.name)
            }

            VStack(alignment: .leading, spacing: Layout.fieldErrorSpacing) {
                FloatingLabelTextField(
                    label: Strings.emailLabel,
                    text: $viewModel.formInput.email,
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    autocapitalization: .never,
                    autocorrectionDisabled: true
                )
                FieldErrorLabel(error: viewModel.errors.email)
            }

            VStack(alignment: .leading, spacing: Layout.fieldErrorSpacing) {
                FloatingLabelTextField(
                    label: Strings.numberLabel,
                    text: $viewModel.formInput.number,
                    keyboardType: .numberPad
                )
                FieldErrorLabel(error: viewModel.errors.number)
            }
        }
    }
}
