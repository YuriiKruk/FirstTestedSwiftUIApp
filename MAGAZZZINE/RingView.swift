//
//  RingView.swift
//  MAGAZZZINE
//
//  Created by Yury Kruk on 21.06.2021.
//

import SwiftUI

struct RingView: View {
    
    var color1 = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var width: CGFloat = 100
    var heignt: CGFloat = 100
    var percent: CGFloat = 78
    
    @Binding var show: Bool
    
    var body: some View {
        let multipplier = width / 44
        let progress = 1 - (percent / 100)
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multipplier))
                .frame(width: width, height: heignt)
            
            Circle()
                .trim(from: show ? 1 : progress, to: 1.0)
                .stroke(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .trailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: 5 * multipplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(width: width, height: heignt)
                .shadow(color: color2.opacity(0.1), radius: 3 * multipplier, x: 0.0, y: 3 * multipplier)
                .animation(.easeInOut(duration: 0.3))
                
            
            Text("\(Int(percent / 5))%")
                .font(.system(size: 14 * multipplier))
                .fontWeight(.bold)
            
            
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
