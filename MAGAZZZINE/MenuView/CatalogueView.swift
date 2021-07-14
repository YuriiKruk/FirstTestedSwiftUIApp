//
//  CatalogueView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI


struct CatalogueView: View {
    
    @State var show2 = false
    @State var showTop = 1
    @State var showDetail = false
    @Binding var show: Bool
    @Binding var sale: Int
    
    @ObservedObject var userSale = Sale()
    @ObservedObject var userOrder: UsersOrder
    
    @State var assortment = Assortment().shoes
    @State var curentModel = 0
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9311889594, green: 0.9311889594, blue: 0.9311889594, alpha: 1)) // Background color view
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
                        })
            
            VStack {
                Spacer()
                Image ("nike logo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.top, 50)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        RingView(color1: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), color2: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), width: 44, heignt: 44, percent: CGFloat(self.userSale.score * 5), show: $show)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ваша знижка")
                                .bold()
                            Text("Ціну зі знижкою ви можете знайти в замовленнях")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(10)
                        .padding(.bottom, 5)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                }
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach (assortment) { shoe in
                            
                            Button(action: {
                                
                                self.curentModel = shoe.index
                                
                                
                            }) {
                                GeometryReader { geometry in
                                    ShoesCatalogView(name: shoe.name)
                                        .overlay(self.curentModel == shoe.index ? RoundedRectangle(cornerRadius: 42).stroke(Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)), lineWidth: 3) : nil)
                                        .rotation3DEffect(
                                            Angle(degrees: (Double(geometry.frame(in: .global).minX) - 30) / -20),
                                            axis: (x: 0.0, y: 10.0, z: 0.0)
                                        )
                                }
                                .frame(width: 275, height: 300)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .padding(.leading, 20)
                }
                
                Button(action: {
                    self.showDetail.toggle()
                }) {
                    Text("Купити")
                        .foregroundColor(.white)
                        .frame(width: 169, height: 42)
                        .background(Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)))
                        .cornerRadius(20)
                        .shadow(color: Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)).opacity(0.6), radius: 10, y: 10)
                        .padding()
                }
                
                Text("Вибрана модель:")
                    .font(.system(size: 18))
                    .bold()
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: 10) {
                        HStack(spacing: 20) {
                            Image(assortment[curentModel].name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70)
                            
                            Text(assortment[curentModel].name)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                        }
                        
                        Text("Технологія Nike Air - цу міцна і гнучка подушка зі стисненим повітрям всередині. Вона підвищує гнучкість і амортизацію, зберігаючи структуру підошви.")
                            .lineLimit(4)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(5)
                            .padding(.horizontal, 5)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: 130)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.bottom, 15)
                    .padding(.leading, 10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    
                }
                Spacer()
            }
            
            DetailView(showDetail: $showDetail, curentModel: $curentModel, userOrder: self.userOrder)
                .offset(y: showDetail ? -100 : 600)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
        
    }
}


struct ShoesCatalogView: View {
    
    var name: String
    @State var shoesState  = CGSize.zero
    
    var body: some View {
        VStack {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 265, height: 368)
                .offset(y: 30)
            
            Text(name)
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .bold()
                .frame(width: 240)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .offset(y: -80)
        }
        .padding(10)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 300)
        .background( Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)))
        .cornerRadius(42)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        
    }
}


struct DetailView: View {
    
    @Binding var showDetail: Bool
    @Binding var curentModel: Int
    @ObservedObject var userOrder: UsersOrder
    
    @State var assortment = Assortment().shoes
    @State var orderSize = "Розмір не вибрано"
    
    let colorChoosenSizeButton = Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Man's Shoe")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            
                            Text(assortment[curentModel].name)
                                .bold()
                        }
                        Spacer()
                        
                        Text("$\(assortment[curentModel].price)")
                            .bold()
                            .font(.system(size: 24))
                            .padding(.top, 25)
                    }
                    .padding(.horizontal)
                    
                    Text("Select Size")
                        .font(.caption)
                        .padding(.horizontal)
                    
                    VStack(alignment: .center, spacing: 8) {
                        HStack(alignment: .center, spacing: 8.0) {
                            
                            Button(action: {
                                self.orderSize = "EU 37"
                                
                            }) {
                                Text("EU 37")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 37" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                self.orderSize = "EU 37.5"
                                
                            }) {
                                Text("EU 37.5")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 37.5" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                self.orderSize = "EU 38"
                                
                            }) {
                                Text("EU 38")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 38" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                        }
                        
                        HStack(alignment: .center, spacing: 10.0) {
                            
                            Button(action: {
                                self.orderSize = "EU 38.5"
                                
                            }) {
                                Text("EU 38.5")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 38.5" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                self.orderSize = "EU 39"
                                
                            }) {
                                Text("EU 39")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 39" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                self.orderSize = "EU 39.5"
                                
                            }) {
                                Text("EU 39.5")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 39.5" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                        }
                        
                        HStack(alignment: .center, spacing: 10.0) {
                            Button(action: {
                                self.orderSize = "EU 40"
                                
                            }) {
                                Text("EU 40")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 40" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                self.orderSize = "EU 40.5"
                                
                            }) {
                                Text("EU 40.5")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 40.5" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                self.orderSize = "EU 41"
                                
                            }) {
                                Text("EU 41")
                                    .font(.footnote)
                                    .frame(width: 102, height: 41)
                                    .foregroundColor(.black)
                                    .background(self.orderSize == "EU 41" ? colorChoosenSizeButton : Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                    .padding(.leading, 30)
                    
                    Button(action: {
                        if self.orderSize != "Розмір не вибрано" {
                            let userOrder = Order(name: self.assortment[curentModel].name, price: self.assortment[curentModel].price, size: self.orderSize)
                            self.userOrder.data.append(userOrder)
                            self.showDetail = false
                            self.orderSize = "Розмір не вибрано"
                        }
                    }) {
                        Text((self.orderSize != "Розмір не вибрано") ? "Добавити в корзину" : "Розмір не вибрано")
                            .foregroundColor(.white)
                            .frame(width: 321, height: 44)
                            .background(Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)))
                            .cornerRadius(20)
                            .shadow(color: Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)).opacity(0.6), radius: 10, y: 10)
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                    }
                }
                .padding(.top, 10)
                
                .frame(width: 383, height: 400)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            }
            
            Image(systemName: "xmark")
                .frame(width: 70, height: 70)
                .foregroundColor(.black)
                .offset(x: 160, y: 80)
                .onTapGesture {
                    self.showDetail = false
                }
        }
    }
}
