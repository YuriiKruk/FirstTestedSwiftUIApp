//
//  StoreAndNewsView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI
import MapKit

struct StoreAndNewsView: View {
    
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

struct StoreLocations: Identifiable {
    var id = UUID()
    var city: String
    var street: String
    
    var coordinateLatitude: Double
    var coordinateLongitude: Double
    
    var index: Int
}
