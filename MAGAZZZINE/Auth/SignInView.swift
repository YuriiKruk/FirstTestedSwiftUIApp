//
//  SignInView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI

struct SignIn: View {
    
    @Binding var indexForMenu: Int
    @Binding var userName: String
    
    @State private var userLogin = ""
    @State private var userPassword = ""
    
    @State var buttonSignIn = "Sign In"
    
    @Binding var indexForLoginView: Int
    @Binding var showAnimationLoginView: Bool
    @Binding var showAnimationSignUpView: Bool
    
    @ObservedObject var userData: UsersData
    
    @State var colorUIMagazzine = ColorUIMagazzine()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    
                    Spacer()
                    
                    Text("Login")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                        .offset(y: -15)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                        
                        TextField("Login", text: $userLogin)
                            
                    }
                    
                    Divider()
                        .frame(width: 320)
                        .background(Color.white.opacity(0.5))
                        .offset(x: -8)
                    
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                        
                        SecureField("Password", text: $userPassword)
                    }
                    
                    Divider()
                        .frame(width: 320)
                        .background(Color.white.opacity(0.5))
                        .offset(x: -8)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        for i in userData.data { 
                            if i.login.lowercased() == self.userLogin.lowercased() && i.password == self.userPassword {
                                self.buttonSignIn = "Successfully"
                                
                                self.userName = i.name
                                self.indexForMenu = 0
                                
                                
                                self.userLogin = ""
                                self.userPassword = ""
                                
                            } else {
                                self.buttonSignIn = "Incorrect login or password"
                            }
                        }
                        
                        
                    }, label: {
                        Text(buttonSignIn)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color(colorUIMagazzine.loginButton))
                            .clipShape(Capsule())
                    })
                    
                    Spacer()
                    
                }
                .padding(.leading)
                .frame(width: 350, height: 300)
                .background(Color(colorUIMagazzine.signIn))
                .cornerRadius(20)
                .offset(y: -300)
                
                .onTapGesture {
                    self.indexForLoginView = 1
                    self.showAnimationLoginView = true
                    self.showAnimationSignUpView = false
                }
            }
        }
    }
}
