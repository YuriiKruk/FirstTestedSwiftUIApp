//
//  SignUpView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI

struct SignUp: View {
    
    @Binding var indexForMenu: Int
    @Binding var userName: String

    
    @State private var userNameSignUp = ""
    @State private var userLogin = ""
    @State private var userPassword = ""
    @State private var userRePassword = ""
    
    @State var buttonStatus = "Sign Up"
    
    @Binding var indexForLoginView: Int
    @Binding var showAnimationLoginView: Bool
    @Binding var showAnimationSignUpView: Bool
    
    @ObservedObject var userData: UsersData
    
    @State var colorUIMagazzine = ColorUIMagazzine()
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                
                VStack(spacing: 26) {
                    
                    Spacer()
                    
                    Text("Sign Up")
                        .font(.title)
                        .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                        .bold()
                        .offset(y: 13)
                    
                    VStack {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                            
                            TextField("Name", text: $userNameSignUp)
                        }
                        Divider()
                            .frame(width: 320)
                            .background(Color.white.opacity(0.5))
                            .offset(x: -8)
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                            
                            TextField("Login", text: $userLogin)
                        }
                        Divider()
                            .frame(width: 320)
                            .background(Color.white.opacity(0.5))
                            .offset(x: -8)
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                            
                            SecureField("Password", text: $userPassword)
                        }
                        Divider()
                            .frame(width: 320)
                            .background(Color.white.opacity(0.5))
                            .offset(x: -8)
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(Color(colorUIMagazzine.loginTextColor))
                            
                            SecureField("Re-password", text: $userRePassword)
                        }
                        Divider()
                            .frame(width: 320)
                            .background(Color.white.opacity(0.5))
                            .offset(x: -8)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if self.userPassword == self.userRePassword && !self.userNameSignUp.isEmpty && !self.userLogin.isEmpty {
                            let usersData = UsersLogin(name: self.userLogin, login: self.userNameSignUp, password: self.userPassword)
                            self.userData.data.append(usersData)
                            
                            
                            self.indexForMenu = 0
                            self.userName = self.userNameSignUp
                            
                            
                            self.userNameSignUp = ""
                            self.userLogin = ""
                            self.userPassword = ""
                            self.userRePassword = ""
                            
                        } else {
                            self.buttonStatus = "Password don't match"
                        }
                    }, label: {
                        Text(self.buttonStatus)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color(colorUIMagazzine.loginButton))
                            .clipShape(Capsule())
                    })
                    .offset(y: -29)
                    
                    Spacer()
                }
                
                .padding(.leading)
                .frame(width: 350, height: 350)
                .background(Color(colorUIMagazzine.signUp))
                .cornerRadius(20)
                .offset(y: -250)
                
                .onTapGesture {
                    self.indexForLoginView = 0
                    self.showAnimationSignUpView = true
                    self.showAnimationLoginView = false
                    
                }
            }
        }
    }
}
