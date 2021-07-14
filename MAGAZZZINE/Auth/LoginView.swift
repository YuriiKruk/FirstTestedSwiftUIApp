//
//  StartPageLoginView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 17.06.2021.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var indexForMenu: Int
    @Binding var userName: String
    
    @State var indexForLoginView = 1
    @State var showAnimationLoginView = true
    @State var showAnimationSignUpView = false
    
    @ObservedObject var userData: UsersData
    
    let colorUIMagazzine = ColorUIMagazzine()
    
    var body: some View {
        ZStack {
            
            Color(colorUIMagazzine.loginBackground)
                .ignoresSafeArea()
            
            SignIn(indexForMenu: self.$indexForMenu, userName: self.$userName, indexForLoginView: self.$indexForLoginView, showAnimationLoginView: self.$showAnimationLoginView, showAnimationSignUpView: self.$showAnimationSignUpView, userData: self.userData)
                .offset(y: showAnimationLoginView ? 100 : 40)
                .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
                .zIndex(Double(self.indexForLoginView))
            
            SignUp(indexForMenu: self.$indexForMenu, userName: self.$userName, indexForLoginView: self.$indexForLoginView, showAnimationLoginView: self.$showAnimationLoginView, showAnimationSignUpView: self.$showAnimationSignUpView, userData: self.userData)
                .offset(y: showAnimationLoginView ? 40 : 100)
                .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
            
            VStack(spacing: 1) {
                Text("MAGAZZZINE")
                    .font(.custom("Bodoni 72", size: 45))
                    .foregroundColor(Color(colorUIMagazzine.signUp))
                
                Text("We have all you need")
                    .font(.custom("American Typewriter", size: 20))
                    .foregroundColor(Color(colorUIMagazzine.signUp))
            }
            .offset(y: -300)
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(indexForMenu: .constant(0), userName: .constant(""), userData: UsersData())
    }
}
