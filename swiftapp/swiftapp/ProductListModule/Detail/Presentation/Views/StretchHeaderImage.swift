//
//  StretchHeaderImage.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import SwiftUI
import Kingfisher


struct StretchHeaderImage: View {

    let url: URL?
    let scrollOffset: CGFloat
    let baseHeight: CGFloat
    let minHeight: CGFloat

    var body: some View {
        KFImage(url)
            .placeholder {
                Color.gray.opacity(0.1)
                    .overlay { ProgressView() }
            }
            .cancelOnDisappear(true)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .frame(height: currentHeight)
            .clipped()
    }

    private var currentHeight: CGFloat {
        let normalized = max(0, scrollOffset)
        return max(minHeight, baseHeight - normalized)
    }

}
