//
//  FieldErrorLabel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct FieldErrorLabel: View {
    let error: ValidationError?

    var body: some View {
        if let error {
            Text(error.userMessage)
                .font(.footnote)
                .foregroundStyle(.red)
        }
    }
}
