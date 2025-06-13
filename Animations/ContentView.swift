//
//  ContentView.swift
//  Animations
//
//  Created by Santhosh Srinivas on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var animationValue = 0.0
    var body: some View {
        
        print(animationAmount)
        
        // as we have some non view code "print" we have to return te VSTACK
        return VStack{
            Stepper("Scale Amount", value: $animationAmount.animation(), in: 1...10)
            Spacer()
            Button("New Button"){
                withAnimation(.spring(response: 1, dampingFraction: 0.5)){
                    animationValue += 360
                }
                // spins 360 when clicked
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationValue), axis: (x: 1.0, y: 0.0, z: 0.0))
            
            Spacer()
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
//        Button("Tap Me"){
////            animationAmount += 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
////        .scaleEffect(animationAmount)
////        .blur(radius: (animationAmount-1)*3)
//        // makes it blurry as it gets big
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeOut(duration: 1)
//                        .repeatForever(autoreverses: true),
//                    value: animationAmount
//                )
//        )
        // this makes a ring go out
//        .animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
//        .animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true), value: animationAmount)
        // causes a smooth animation
//        .onAppear{ animationAmount = 2 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
