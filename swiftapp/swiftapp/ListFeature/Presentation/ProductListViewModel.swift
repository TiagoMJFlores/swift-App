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
            let products = try await interactor.loadProducts()
            state = .loaded(products.map { $0.toViewItem() })
        } catch {
            state = .failed(ProductListErrorMessageMapper.loadProducts(error).userMessage)
        }
    }
}
