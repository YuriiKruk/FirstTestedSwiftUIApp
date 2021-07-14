//
//  ContentView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 10.06.2021.
//

import SwiftUI
import MapKit

struct AppView: View {
    
    @State var indexForMenu = 1
    @ObservedObject var sharedUserData = UsersData()
    @State var userName = ""
    
    var body: some View {
        
        ZStack {
            
            Menu(indexForMenu: self.$indexForMenu, userData: self.sharedUserData, userName: self.$userName)
            
            LoginView(indexForMenu: self.$indexForMenu, userName: self.$userName, userData: self.sharedUserData)
                .offset(y: self.indexForMenu == 1 ? 0 : -1000)
                .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 1))
            
        }
    }
}

struct ColorUIMagazzine {
    let loginBackground = UIColor(rgb: 0x212529)
    let signIn = UIColor(rgb: 0xf9dbbd)
    let signUp = UIColor(rgb: 0xecc8af)
    let loginButton = UIColor(rgb: 0xfe5f55)
    let loginTextColor = UIColor(rgb: 0x1d3557)
    let backgroundColor = UIColor(rgb: 0x6d6875)
    let buttonColor = UIColor(rgb: 0xe5989b)
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}


