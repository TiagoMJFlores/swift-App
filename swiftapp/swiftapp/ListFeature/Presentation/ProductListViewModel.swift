//
//  ProductListViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Observation
import Resolver

@MainActor
@Observable
final class ProductListViewModel {

    enum ViewState {
        case idle
        case loading
        case loaded([ProductViewItem])
        case failed(String)
    }

    private(set) var state: ViewState = .idle

    @ObservationIgnored
    @Injected private var interactor: ProductListInteractorProtocol

    func load() async {
        state = .loading
        do {
            for try await products in interactor.productsStream() {
                let items = products.map { $0.toViewItem() }
                state = items.isEmpty ? .loading : .loaded(items)
            }
        } catch {
            state = .failed(ProductListErrorMessageMapper.loadProducts(error).userMessage)
        }
    }
}
