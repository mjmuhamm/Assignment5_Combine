//
//  ContentView.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ProductViewModel(networkManager: NetworkManager())
    
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
            case .loaded(let inventory):
                loadList(inventory: inventory)
            case .apiError(let error):
                Text(error.localizedDescription)
            case .empty:
                EmptyView()
            }
        }.onAppear {
            viewModel.getInfo()
        }.refreshable {
            viewModel.getInfo()
        }
    }
    
    @ViewBuilder
    func loadList(inventory: [Inventory]) -> some View {
        NavigationStack {
            VStack {
                Text("Products")
                List(inventory) { product in
                    InventoryCell(product: product)
                }
            }.padding(.vertical, 6)
            
        }
    }
}

#Preview {
   MainView()
}
