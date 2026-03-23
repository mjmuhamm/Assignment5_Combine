//
//  ProductViewModel.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import Foundation
import Combine

enum ProductListState {
    case loading
    case loaded([Inventory])
    case apiError(Error)
    case empty
}

final class ProductViewModel: ObservableObject {
    

    @Published var viewState: ProductListState = .loading
    
    let networkManager : Network
    var cancellable = Set<AnyCancellable>()
    
    init(networkManager: Network) {
        self.networkManager = networkManager
    }
    
    func getInfo() {
        viewState = .loading
        networkManager.getInfo(urlString: Constants.BASE_URL, modelType: [Inventory].self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Tasks completed")
                case .failure(let error):
                    self?.viewState = .apiError(error)
                    print(error)
                }
            } receiveValue: { [weak self] inventory in
                self?.viewState = .loaded(inventory)
                self?.saveInventoryCount(inventory: inventory)
            }.store(in: &cancellable)
    }
    
    func saveInventoryCount(inventory: [Inventory]) {
           UserDefaults.standard.set(inventory.count, forKey: "InventoryCount")
       }
}
