//
//  RatingRow.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct RatingRow: View {

    private enum Layout {
        static let spacing: CGFloat = 4
    }

    let label: String
    let iconName: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            HStack(spacing: Layout.spacing) {
                Image(systemName: iconName)
                    .foregroundStyle(.yellow)
                Text(value)
                    .fontWeight(.medium)
            }
        }
    }
}
