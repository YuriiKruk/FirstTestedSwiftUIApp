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
                        
                        for i in userData.data { // Перевірка вірності пароля
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

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(indexForMenu: .constant(0), userName: .constant(""), userData: UsersData())
    }
}
