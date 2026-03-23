//
//  InventoryDetailScreen.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import SwiftUI

struct InventoryDetailScreen: View {
    let product : Inventory
    var body: some View {
        VStack(alignment: .center) {
            
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: 250, height: 250)
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .foregroundColor(.gray)
            }.padding(.bottom, 9)
            
            Text(product.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 1.5)
            
            Text(String(format: "$%.2f", product.price))
            
        }.padding(10)
        
        VStack(alignment: .leading) {
            Text("Id: \(product.id)").padding(.top, 0.2)
            Text("Description: \(product.description)").padding(.top, 0.2)
            Text("Category: \(product.category)").padding(.top, 0.2)
            Text("Rating: \(product.rating.rate, specifier: "%.2f")").padding(.top, 0.2)
            
        }.padding(10).frame(alignment: .topLeading)
        
        Text("* \(product.rating.count) ratings of this product *").padding(.top, 0.5).foregroundStyle(.gray).font(.system(size: 15))
    }
}

#Preview {
    InventoryDetailScreen(product: Inventory(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 154.1, description: "23", category: "23", image: "23", rating: Rating(rate: 15.3, count: 3)))
}
