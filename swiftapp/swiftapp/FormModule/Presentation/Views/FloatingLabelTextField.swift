//
//  FloatingLabelTextField.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import UIKit

struct FloatingLabelTextField: View {

    private enum Layout {
        static let topPadding: CGFloat = 16
        static let floatingScale: CGFloat = 0.75
        static let floatingOffsetY: CGFloat = -22
        static let animationDuration: Double = 0.2
    }

    let label: String
    @Binding var text: String

    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?
    var autocapitalization: TextInputAutocapitalization = .sentences
    var autocorrectionDisabled: Bool = false

    @FocusState private var isFocused: Bool

    private var isFloating: Bool { isFocused || !text.isEmpty }

    var body: some View {
        ZStack(alignment: .leading) {
            Text(label)
                .foregroundStyle(isFloating ? Color.accentColor : .secondary)
                .scaleEffect(isFloating ? Layout.floatingScale : 1, anchor: .topLeading)
                .offset(y: isFloating ? Layout.floatingOffsetY : 0)
                .animation(.easeInOut(duration: Layout.animationDuration), value: isFloating)

            TextField("", text: $text)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled(autocorrectionDisabled)
        }
        .padding(.top, Layout.topPadding)
    }
}
