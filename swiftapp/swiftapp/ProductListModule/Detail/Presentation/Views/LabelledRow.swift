//
//  LabelledRow.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct LabelledRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
