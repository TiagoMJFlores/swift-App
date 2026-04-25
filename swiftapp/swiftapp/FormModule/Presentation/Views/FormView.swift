//
//  FormView.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Resolver

struct FormView: View {

    private enum Strings {
        static let navigationTitle = "Form"
        static let confirmAction = "OK"
        static let successTitle = "Thank you!"
        static let successMessage = "Your submission was recorded."
    }

    @State private var viewModel: FormViewModel

    init() {
        _viewModel = State(wrappedValue: Resolver.resolve())
    }

    var body: some View {
        NavigationStack {
            Form {
                UserDetailsSection(viewModel: viewModel)
                PromoSection(viewModel: viewModel)
                DeliverySection(viewModel: viewModel)
                RatingSection(viewModel: viewModel)
            }
            .navigationTitle(Strings.navigationTitle)
            .scrollDismissesKeyboard(.interactively)
            .safeAreaInset(edge: .bottom) {
                FormActionsBar(viewModel: viewModel)
            }
            .alert(Strings.successTitle, isPresented: successBinding) {
                Button(Strings.confirmAction) { viewModel.reset() }
            } message: {
                Text(Strings.successMessage)
            }
        }
    }

    private var successBinding: Binding<Bool> {
        Binding(
            get: { viewModel.didSubmit },
            set: { if !$0 { viewModel.reset() } }
        )
    }
}
