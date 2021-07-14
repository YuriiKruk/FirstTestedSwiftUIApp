//
//  UsersOrderData.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI

struct Shoes: Identifiable {
    var id = UUID()
    let name: String
    let price: Int
    let index: Int
}

struct Assortment {
    let shoes = [Shoes(name: "The Nike Air Max 1", price: 140, index: 0),
                 Shoes(name: "Nike Dunk Low Viotec Kids", price: 399, index: 1),
                 Shoes(name: "The Air Jordan 1 Retro High «Bloodline»", price: 125, index: 2),
                 Shoes(name: "The Nike Air Huarache", price: 110, index: 3),
                 Shoes(name: "The Nike Air Max 90", price: 120, index: 4),
                 Shoes(name: "The Nike Air Max 95", price: 160, index: 5),
                 Shoes(name: "The Nike Cortez", price: 75, index: 6),
                 Shoes(name: "Tom Sachs x Nike Mars Yard", price: 3599, index: 7)]
}

struct Order: Codable, Identifiable {
    var id = UUID()
    var name: String
    var price: Int
    var size: String
}

class UsersOrder: ObservableObject {
    @Published var data = [Order]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(data) {
                UserDefaults.standard.set(encoded, forKey: "Order")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "Order") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Order].self, from: data) {
                self.data = decoded
                return
            }
        }
    }
}

class Sale: ObservableObject {
    @Published var score: Int = UserDefaults.standard.integer(forKey: "score") {
        didSet {
            UserDefaults.standard.set(self.score, forKey: "score")
        }
    }
    
}
