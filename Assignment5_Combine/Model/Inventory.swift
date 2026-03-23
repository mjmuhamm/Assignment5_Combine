//
//  Inventory.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import Foundation

struct Inventory: Decodable, Identifiable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: Rating
}

struct Rating: Decodable {
    var rate: Double
    var count: Int
}
