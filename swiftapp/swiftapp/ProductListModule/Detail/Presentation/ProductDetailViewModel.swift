//
//  ProductDetailViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Observation
import Resolver

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
    @Injected private var interactor: ProductDetailInteractorProtocol

    func load(productId: Int) {
        state = .loading
        do {
            guard let product = try interactor.loadProduct(id: productId) else {
                state = .failed(ProductDetailErrorMessageMapper.notFound.userMessage)
                return
            }
            state = .loaded(product.toDetailViewItem())
        } catch {
            state = .failed(ProductDetailErrorMessageMapper.loadProduct(error).userMessage)
        }
    }
}
