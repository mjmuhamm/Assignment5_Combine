//
//  ContentView.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ProductViewModel(networkManager: NetworkManager())
    
    //Is updated in ViewModel every time getInfo() function is called to provide proper inventory count - Proper use of AppStorage; could be applied to CommentSection count of ImageApp or Reviews of Products count
    @AppStorage("InventoryCount") var inventoryCount = 0
    
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
                
                Text("Products: \(inventoryCount)")
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
