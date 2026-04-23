//
//  ListViewModel.swift
//  swiftapp
//
//  Created by Tiago Flores on 23/04/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class ListViewModel {

    enum ViewState {
        case idle
        case loading
        case loaded([Product])
        case failed(String)
    }

    private(set) var state: ViewState = .idle

    private let repository: ProductRepository
    private let pageSize: Int

    init(repository: ProductRepository, pageSize: Int = 30) {
        self.repository = repository
        self.pageSize = pageSize
    }

    func load() async {
        state = .loading
        do {
            let products = try await repository.fetchProducts(limit: pageSize, skip: 0)
            state = .loaded(products)
        } catch {
            state = .failed(ListErrorMessageMapper.loadProducts(error).userMessage)
        }
    }
}
