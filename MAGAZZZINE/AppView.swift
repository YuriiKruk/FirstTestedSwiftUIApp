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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}


