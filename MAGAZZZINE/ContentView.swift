//
//  ContentView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 10.06.2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var indexForMenu = 1
    @ObservedObject var sharedUserData = UsersData()
    @State var userName = ""
    
    var body: some View {
        
        ZStack {
            
            Menu(indexForMenu: self.$indexForMenu, userData: self.sharedUserData, userName: self.$userName)
            
            LoginView(indexForMenu: self.$indexForMenu, userName: self.$userName, userData: self.sharedUserData) // Вю входу
                .offset(y: self.indexForMenu == 1 ? 0 : -1000)
                .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 1))
            
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

struct ColorUIMagazzine {
    
    @State var loginBackground = UIColor(hex: "#" + "212529")
    @State var signIn = UIColor(hex: "#" + "f9dbbd")
    @State var signUp = UIColor(hex: "#" + "ecc8af")
    @State var loginButton = UIColor(hex: "#" + "fe5f55")
    @State var loginTextColor = UIColor(hex: "#" + "1d3557")
    
    var backgroundColor = UIColor(hex: "#6d6875")
    var buttonColor = UIColor(hex: "#e5989b")
    
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


