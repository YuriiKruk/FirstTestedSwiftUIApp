//
//  MenuView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 17.06.2021.
//

import SwiftUI
import MapKit

struct Menu: View {
    
    @Binding var indexForMenu: Int
    @ObservedObject var userData: UsersData
    @ObservedObject var userOrder = UsersOrder()
    
    let colorDesign = ColorUIMagazzine()
    
    @State var index = 0
    @State var show = true
    @State var sale = 0
    @Binding var userName: String
    
    
    var body: some View {
        ZStack {
            
            MenuButtonsView(userName: self.$userName, index: self.$index, indexForMenu: self.$indexForMenu, show: self.$show)
            
            ZStack {
                switch index {
                case 0:
                    CatalogueView(show: self.$show, sale: self.$sale, userOrder: self.userOrder)
                case 1:
                    OrdersView(userOrder: self.userOrder, show: self.$show, sale: self.$sale)
                case 2:
                    StoreAndNewsView(show: self.$show)
                default: SaleGameView(sale: self.$sale, show: self.$show)
                }
                
                Button(action: {
                    withAnimation {
                        self.show.toggle()
                    }
                }) {
                    Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                        .resizable()
                        .frame(width: self.show == true ? 25 : 22, height: self.show == true ? 25 : 22)
                        
                        // .frame(width: self.show ? 18 : 22, height: 18) - крашить! ВТФ???
                        .foregroundColor(Color.black.opacity(0.4))
                } .offset(x: self.show == true ? -177 : -177, y: self.show == true ? -420 : -380)
            }
            .background(Color.white)
            .cornerRadius(self.show ? 30 : 0)
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
            .rotationEffect(.init(degrees: self.show ? -5 : 0))
        }
        .background(Color(colorDesign.backgroundColor).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuButtonsView: View {
    
    let colorDesign = ColorUIMagazzine()

    @Binding var userName: String
    @Binding var index: Int
    @Binding var indexForMenu: Int
    @Binding var show: Bool

    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Image("UserAvatar1")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                
                Text("Привіт,")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                Text(userName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Button(action: {
                    self.index = 0
                    
                    withAnimation {
                        self.show.toggle()
                    }
                }) {
                    HStack(spacing: 25) {
                        Image(systemName: "bookmark.circle.fill")
                            .foregroundColor(self.index == 0 ? Color(colorDesign.buttonColor) : Color.white)
                        Text("Каталог")
                            .foregroundColor(self.index == 0 ? Color(colorDesign.buttonColor) : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.index == 0 ? Color(colorDesign.buttonColor).opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                .padding(.top, 25)
                
                Button(action: {
                    self.index = 1
                    
                    withAnimation {
                        self.show.toggle()
                    }
                }) {
                    HStack(spacing: 25) {
                        Image(systemName: "bag.circle.fill")
                            .foregroundColor(self.index == 1 ? Color(colorDesign.buttonColor) : Color.white)
                        Text("Мої замовлення")
                            .foregroundColor(self.index == 1 ? Color(colorDesign.buttonColor) : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.index == 1 ? Color(colorDesign.buttonColor).opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                Button(action: {
                    self.index = 2
                    
                    withAnimation {
                        self.show.toggle()
                    }
                }) {
                    HStack(spacing: 25) {
                        Image(systemName: "heart.circle.fill")
                            .foregroundColor(self.index == 2 ? Color(colorDesign.buttonColor) : Color.white)
                        Text("Наші магазини")
                            .foregroundColor(self.index == 2 ? Color(colorDesign.buttonColor) : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.index == 2 ? Color(colorDesign.buttonColor).opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                Button(action: {
                    self.index = 3
                    
                    withAnimation {
                        self.show.toggle()
                    }
                }) {
                    HStack(spacing: 25) {
                        Image(systemName: "wallet.pass.fill")
                            .foregroundColor(self.index == 3 ? Color(colorDesign.buttonColor) : Color.white)
                        Text("Міні-гра")
                            .foregroundColor(self.index == 3 ? Color(colorDesign.buttonColor) : Color.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.index == 3 ? Color(colorDesign.buttonColor).opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                }
                
                Divider()
                    .frame(width: 150, height: 1)
                    .background(Color.white)
                    .padding(.vertical, 30)
                
                Button(action: {
                    self.indexForMenu = 1
                }) {
                    HStack {
                        Image(systemName: "delete.right.fill")
                            .foregroundColor(.white)
                        Text("Вихід")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 25)
            .padding(.horizontal, 20)
            Spacer(minLength: 0)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }
}
