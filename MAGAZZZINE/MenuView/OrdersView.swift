//
//  OrdersView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI


struct OrdersView: View {
    
    @ObservedObject var userOrder: UsersOrder
    @Binding var show: Bool
    @Binding var sale: Int
    @ObservedObject var userSale = Sale()
    
    @State var showDetailOrderView = false
    @State var curentIndex = Order(name: "", price: 0, size: "")
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: self.show == true ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.top)
            Text("Мої замовлення")
                .font(.largeTitle)
                .bold()
            ZStack {
                List {
                    ForEach(userOrder.data) { item in
                        HStack {
                            Image(item.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text("Size: \(item.size)")
                            }
                            Spacer()
                            VStack {
                                Text("$\(item.price)")
                                    .fontWeight(sale == 0 ? .bold : .light)
                                    .font(.system(size: 20))
                                
                                if userSale.score > 0 {
                                    let s: Double = (Double(userSale.score)/100)
                                    let b = s * Double(item.price)
                                    let c = item.price - Int(b)
                                    
                                    VStack {
                                        Text("with sale:")
                                            .font(.caption)
                                        Text("$\(c)")
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                            .font(.system(size: 20))
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                withAnimation(.spring()) {
                                    if self.showDetailOrderView {
                                        
                                        withAnimation(.spring()) {
                                            self.showDetailOrderView = false
                                        }
                                        withAnimation(.spring().delay(0.4)) {
                                            self.showDetailOrderView = true
                                            curentIndex = item.self
                                        }
                                    } else {
                                        withAnimation(.spring()) {
                                            self.showDetailOrderView = true
                                            curentIndex = item.self
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                    
                }
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }}
                
                DetailOrder(showDetailOrderView: self.$showDetailOrderView, name: curentIndex.name, price: curentIndex.price, size: curentIndex.size)
                
            }
            
            
            
        }
        .background(
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) // Background color view
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded { value in
                            if value.translation.width < 0 {
                                withAnimation {
                                    self.show = false
                                }
                            }
                            
                            if value.translation.width > 0 {
                                withAnimation {
                                    self.show = true
                                }
                            }
                        }))
    }
    func removeItems (as offsets: IndexSet) {
        userOrder.data.remove(atOffsets: offsets)
    }
}


struct DetailOrder: View {
    
    @Binding var showDetailOrderView: Bool
    
    var name = "Some shoes"
    var price = 0
    var size = "404"
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    VStack {
                        Text(name)
                            .bold()
                            .padding(.trailing, 10)
                            .multilineTextAlignment(.center)
                        
                        Text(size)
                            .font(.body)
                    }
                    
                }
                Text("Технологія Nike Air - цу міцна і гнучка подушка зі стисненим повітрям всередині. Вона підвищує гнучкість і амортизацію, зберігаючи структуру підошви.")
                    .lineLimit(6)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .padding(5)
                    .padding(.horizontal, 5)
                
                
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: 200)
            .background(Color.white)
            .cornerRadius(44)
            .padding(.bottom, 25)
            
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .offset(y: showDetailOrderView ? 0 : 1000)
            
            
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.height > 0 || value.translation.height < 0 {
                            withAnimation {
                                self.showDetailOrderView = false
                            }
                        }
                    })
        }
    }
}
