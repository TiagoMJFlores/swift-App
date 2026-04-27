//
//  FormActionsBar.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct FormActionsBar: View {

    private enum Strings {
        static let submit = "Submit"
        static let reset = "Reset"
    }

    private enum Layout {
        static let spacing: CGFloat = 12
    }

    @ObservedObject var viewModel: FormViewModel

    var body: some View {
        HStack(spacing: Layout.spacing) {
            Button(Strings.reset, role: .destructive) { viewModel.reset() }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)

            Button(Strings.submit) { viewModel.submit() }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .disabled(!viewModel.isSubmitEnabled)
        }
        .padding()
        .background(.bar)
    }
}
