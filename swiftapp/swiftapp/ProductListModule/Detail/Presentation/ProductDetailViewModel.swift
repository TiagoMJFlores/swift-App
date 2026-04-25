//
//  ProductDetailViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Observation
import Dependencies

@MainActor
@Observable
final class ProductDetailViewModel {

    enum ViewState {
        case idle
        case loading
        case loaded(ProductDetailViewItem)
        case failed(String)
    }

    private(set) var state: ViewState = .idle

    @ObservationIgnored
    @Dependency(\.productDetailInteractor) private var interactor

    func load(productId: Int) async {
        state = .loading
        do {
            guard let product = try await interactor.loadProduct(id: productId) else {
                state = .failed(ProductDetailErrorMessageMapper.notFound.userMessage)
                return
            }
            state = .loaded(product.toDetailViewItem())
        } catch {
            state = .failed(ProductDetailErrorMessageMapper.loadProduct(error).userMessage)
        }
    }
}

private enum ProductDetailViewModelKey: DependencyKey {
    static let liveValue: @MainActor () -> ProductDetailViewModel = {
        ProductDetailViewModel()
    }
}

extension DependencyValues {
    var makeProductDetailViewModel: @MainActor () -> ProductDetailViewModel {
        get { self[ProductDetailViewModelKey.self] }
        set { self[ProductDetailViewModelKey.self] = newValue }
    }
}
