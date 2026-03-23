//
//  InventoryCell.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import SwiftUI

struct InventoryCell: View {
    let product : Inventory
    var body: some View {
        NavigationLink {
            InventoryDetailScreen(product: product)
        } label: {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .frame(width: 100, height: 100)
                } placeholder: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text(product.title).fontWeight(.bold)
                }
            }.padding(10)
        }
    }
}

#Preview {
    InventoryCell(product: Inventory(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 154.1, description: "23", category: "23", image: "23", rating: Rating(rate: 15.3, count: 3)))
}
