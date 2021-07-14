//
//  UsersData.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI

struct UsersLogin: Codable {
    var name: String
    var login: String
    var password: String
}

class UsersData: ObservableObject {
    @Published var data = [UsersLogin]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(data) {
                UserDefaults.standard.set(encoded, forKey: "Data")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "Data") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([UsersLogin].self, from: data) {
                self.data = decoded
                return
            }
        }
    }
}
