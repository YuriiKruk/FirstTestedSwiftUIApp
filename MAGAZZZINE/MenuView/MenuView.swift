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
                    Catalogue(show: self.$show, sale: self.$sale, userOrder: self.userOrder)
                case 1:
                    Orders(userOrder: self.userOrder, show: self.$show, sale: self.$sale)
                case 2:
                    StoreAndNews(show: self.$show)
                default: SaleGame(sale: self.$sale, show: self.$show)
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

struct Catalogue: View {
    
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


struct Shoes: Identifiable {
    var id = UUID()
    let name: String
    let price: Int
    let index: Int
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


struct Orders: View {
    
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

struct Order: Codable, Identifiable {
    var id = UUID()
    var name: String
    var price: Int
    var size: String
}

class UsersOrder: ObservableObject {
    @Published var data = [Order]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(data) {
                UserDefaults.standard.set(encoded, forKey: "Order")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "Order") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Order].self, from: data) {
                self.data = decoded
                return
            }
        }
    }
}
struct StoreAndNews: View {
    
    @Binding var show: Bool
    
    @State var showMap = false
    @State var storeLocations = [StoreLocations(city: "Київ, Україна", street: "вул. Львівська, 204", coordinateLatitude: 50.49, coordinateLongitude: 30.56, index: 0),
                                 StoreLocations(city: "Brehna, Germany", street: "st. Thiemendorfer Mark, 1", coordinateLatitude: 51.79, coordinateLongitude: 13.00, index: 1),
                                 StoreLocations(city: "Brussels, Belgium", street: "st. Rue Neuve, 54", coordinateLatitude: 51.09, coordinateLongitude: 4.90, index: 2),
                                 StoreLocations(city: "London, UK", street: "st. Oxford, 236", coordinateLatitude: 51.53, coordinateLongitude: -0.14, index: 3),
                                 StoreLocations(city: "Rome, Italy", street: "st. Via del Corso, 171", coordinateLatitude: 41.89, coordinateLongitude: 12.50, index: 4)]
    @State var curentStore = 0
    let buttonsize = CGFloat((UIScreen.main.bounds.width / 2) - 30)
    
    var body: some View {
        VStack {
            Text("Наші магазини")
                .font(.largeTitle)
                .bold()
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, self.show ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.top)
                
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
            
            ScrollView {
                
                HStack(spacing: 15) {
                    Button(action: {
                        self.curentStore = 0
                        self.showMap.toggle()
                    }) {
                        
                        
                        VStack(alignment: .leading) {
                            Text(storeLocations[0].city)
                                .font(.body)
                                .foregroundColor(.black)
                            Text(storeLocations[0].street)
                                .font(.footnote)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                            
                        }
                        .padding(10)
                        .frame(width: buttonsize, height: buttonsize * 0.6)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .padding(.bottom, 25)
                    }
                    
                    Button(action: {
                        self.curentStore = 1
                        self.showMap.toggle()
                    }) {
                        
                        
                        VStack(alignment: .leading) {
                            Text(storeLocations[1].city)
                                .font(.body)
                                .foregroundColor(.black)
                            Text(storeLocations[1].street)
                                .font(.footnote)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                            
                            
                            
                        }
                        .padding(10)
                        .frame(width: buttonsize, height: buttonsize * 0.6)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .padding(.bottom, 25)
                    }
                }
                .padding(.top, 15)
                
                HStack(spacing: 15) {
                    Button(action: {
                        self.curentStore = 2
                        self.showMap.toggle()
                    }) {
                        
                        
                        VStack(alignment: .leading) {
                            Text(storeLocations[2].city)
                                .font(.body)
                                .foregroundColor(.black)
                            Text(storeLocations[2].street)
                                .font(.footnote)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                            
                            
                            
                        }
                        .padding(10)
                        .frame(width: buttonsize, height: buttonsize * 0.6)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .padding(.bottom, 25)
                    }
                    
                    
                    
                    Button(action: {
                        self.curentStore = 3
                        self.showMap.toggle()
                    }) {
                        
                        
                        VStack(alignment: .leading) {
                            Text(storeLocations[3].city)
                                .font(.body)
                                .foregroundColor(.black)
                            Text(storeLocations[3].street)
                                .font(.footnote)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                            
                            
                            
                        }
                        .padding(10)
                        .frame(width: buttonsize, height: buttonsize * 0.6)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .padding(.bottom, 25)
                    }
                }
                Text("Послідні новини")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.bottom, 15)
                
                VStack(alignment: .leading) {
                    Text("Тут мав бути текст але щось пішло не по плану")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                }
            }
            
        }
        .onTapGesture {
            withAnimation {
                self.show = false
            }
            
        }
        .sheet(isPresented: $showMap) {
            MapView2(showMap: $showMap, storeLocations: $storeLocations, curentStore: $curentStore)
        }
        
    }
}

struct StoreLocations: Identifiable {
    var id = UUID()
    var city: String
    var street: String
    
    var coordinateLatitude: Double
    var coordinateLongitude: Double
    
    var index: Int
}

struct MapView2: View {
    
    @Binding var showMap: Bool
    @Binding var storeLocations: [StoreLocations]
    @Binding var curentStore: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                        .frame(height: 5)
                    Text(storeLocations[curentStore].city)
                        .font(.headline)
                        .bold()
                    
                    Text(storeLocations[curentStore].street)
                        
                        .frame(width: 240, alignment: .leading)
                        .lineLimit(1)
                }
                Spacer()
                Button(action: {
                    
                    self.showMap.toggle()
                    
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                        .offset(y: 5)
                    
                })
                Spacer()
            }
            
            MapView(storeLocations: self.$storeLocations, curentStore: self.$curentStore)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MapView: UIViewRepresentable {
    
    @Binding var storeLocations: [StoreLocations]
    @Binding var curentStore: Int
    
    func makeUIView(context: Context) -> some MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = storeLocations[curentStore].city
        annotation.subtitle = storeLocations[curentStore].street
        annotation.coordinate = CLLocationCoordinate2DMake(storeLocations[curentStore].coordinateLatitude, storeLocations[curentStore].coordinateLongitude)
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        
        func mapView (_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct Assortment {
    let shoes = [Shoes(name: "The Nike Air Max 1", price: 140, index: 0),
                 Shoes(name: "Nike Dunk Low Viotec Kids", price: 399, index: 1),
                 Shoes(name: "The Air Jordan 1 Retro High «Bloodline»", price: 125, index: 2),
                 Shoes(name: "The Nike Air Huarache", price: 110, index: 3),
                 Shoes(name: "The Nike Air Max 90", price: 120, index: 4),
                 Shoes(name: "The Nike Air Max 95", price: 160, index: 5),
                 Shoes(name: "The Nike Cortez", price: 75, index: 6),
                 Shoes(name: "Tom Sachs x Nike Mars Yard", price: 3599, index: 7)]
}

struct SaleGame: View {
    
    @State var assortment = Assortment().shoes.shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @Binding var sale: Int
    @Binding var show: Bool
    @State private var showingSale = false
    @State private var saleTitle = ""
    @ObservedObject var userSale = Sale()
    
    
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
            ZStack {
                
                VStack {
                    Text("Choose model: ")
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .font(.custom("Helvetica-Light", size: 20))
                        .padding(.bottom, 2)
                    
                    Text(assortment[correctAnswer].name)
                        .foregroundColor(.black)
                        .font(.custom("Helvetica-Light", size: 20))
                        .frame(width: 300)
                        .multilineTextAlignment(.center)
                }
                .padding(15)
                .background(Color(#colorLiteral(red: 0.9677101927, green: 0.9677101927, blue: 0.9677101927, alpha: 1)))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                .zIndex(0)
                .offset(y: -310)
                
                
                VStack {
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                            self.showingSale = true
                        }) {
                            Image(self.assortment[number].name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                            
                        }
                    }
                }
                RingView(color1: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), color2: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), width: 70, heignt: 70, percent: CGFloat(self.userSale.score * 5), show: $show)
                    .offset(y: 340)
            }
            
        } .alert(isPresented: $showingSale) {
            Alert(title: Text(saleTitle), message: Text("Sale: \(userSale.score)%"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    func askQuestion() {
        assortment.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer && userSale.score < 19 {
            saleTitle = "Correct answer!"
            userSale.score += 1
        } else if number == correctAnswer && userSale.score <= 20  {
            saleTitle = "Correct answer! You have a maximum discount of 20%"
            userSale.score = 20
        } else {
            saleTitle = "Incorrect! \n This is \(assortment[number].name)"
            if userSale.score == 0 {
                userSale.score = 0
            } else {
                userSale.score -= 1
            }
        }
    }
}

class Sale: ObservableObject {
    @Published var score: Int = UserDefaults.standard.integer(forKey: "score") {
        didSet {
            UserDefaults.standard.set(self.score, forKey: "score")
        }
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
