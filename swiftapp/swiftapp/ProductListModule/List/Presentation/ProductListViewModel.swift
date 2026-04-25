//
//  ProductListViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Combine
import Resolver

final class ProductListViewModel: ObservableObject {

    enum ViewState {
        case idle
        case loading
        case loaded([Product])
        case failed(String)
    }

    @Published private(set) var state: ViewState = .idle
    @Published var searchQuery: String = ""
    @Published private(set) var displayedItems: [ProductViewItem] = []

    @Injected private var interactor: ProductListInteractorProtocol

    private var cancellables = Set<AnyCancellable>()

    init() {
        bindSearch()
    }

    private func bindSearch() {
        Publishers.CombineLatest(
            $state,
            $searchQuery
                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                .removeDuplicates()
        )
        .map { [interactor] state, query -> [ProductViewItem] in
            guard case .loaded(let products) = state else { return [] }
            return interactor
                .search(query: query, in: products)
                .map { $0.toViewItem() }
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &$displayedItems)
    }

    func load() async {
        state = .loading
        do {
            for try await products in interactor.productsStream() {
                state = products.isEmpty ? .loading : .loaded(products)
            }
        } catch {
            state = .failed(ProductListErrorMessageMapper.loadProducts(error).userMessage)
        }
    }
}
