//
//  SaleGameView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 14.07.2021.
//

import SwiftUI


struct SaleGameView: View {
    
    @State var assortment = Assortment().shoes.shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @Binding var sale: Int
    @Binding var show: Bool
    @State private var showingSale = false
    @State private var saleTitle = ""
    @ObservedObject var userSale = Sale()
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9311889594, green: 0.9311889594, blue: 0.9311889594, alpha: 1)) 
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
