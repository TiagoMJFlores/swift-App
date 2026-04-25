//
//  DeliverySection.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct DeliverySection: View {

    private enum Strings {
        static let title = "Delivery"
        static let deliveryDateLabel = "Delivery date"
    }

    private enum Layout {
        static let fieldErrorSpacing: CGFloat = 4
    }

    @Bindable var viewModel: FormViewModel

    var body: some View {
        Section(Strings.title) {
            VStack(alignment: .leading, spacing: Layout.fieldErrorSpacing) {
                DatePicker(
                    Strings.deliveryDateLabel,
                    selection: $viewModel.deliveryDate,
                    displayedComponents: .date
                )
                FieldErrorLabel(error: viewModel.dateError)
            }
        }
    }
}
