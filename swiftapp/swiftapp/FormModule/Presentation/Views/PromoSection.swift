//
//  PromoSection.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct PromoSection: View {

    private enum Strings {
        static let title = "Promo"
        static let promoCodeLabel = "Promo code"
    }

    private enum Layout {
        static let fieldErrorSpacing: CGFloat = 4
    }

    @ObservedObject var viewModel: FormViewModel

    var body: some View {
        Section(Strings.title) {
            VStack(alignment: .leading, spacing: Layout.fieldErrorSpacing) {
                FloatingLabelTextField(
                    label: Strings.promoCodeLabel,
                    text: $viewModel.formInput.promoCode,
                    autocapitalization: .characters,
                    autocorrectionDisabled: true
                )
                FieldErrorLabel(error: viewModel.errors.promoCode)
            }
        }
    }
}
