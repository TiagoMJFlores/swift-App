//
//  RatingSection.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI

struct RatingSection: View {

    private enum Strings {
        static let title = "Feedback"
        static let ratingLabel = "Rating"
        static let ratingPlaceholder = "Choose a rating"
    }

    private enum Layout {
        static let fieldErrorSpacing: CGFloat = 4
    }

    @ObservedObject var viewModel: FormViewModel

    var body: some View {
        Section(Strings.title) {
            VStack(alignment: .leading, spacing: Layout.fieldErrorSpacing) {
                Picker(Strings.ratingLabel, selection: $viewModel.formInput.rating) {
                    Text(Strings.ratingPlaceholder).tag(Rating?.none)
                    ForEach(Rating.allCases) { rating in
                        Text(rating.rawValue).tag(Optional(rating))
                    }
                }
                FieldErrorLabel(error: viewModel.errors.rating)
            }
        }
    }
}
