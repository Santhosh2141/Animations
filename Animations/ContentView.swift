//
//  ContentView.swift
//  Animations
//
//  Created by Santhosh Srinivas on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap Me"){
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount-1)*3)
        // makes it blurry as it gets big
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: animationAmount
                )
        )
        // this makes a ring go out
//        .animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
//        .animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true), value: animationAmount)
        // causes a smooth animation
        .onAppear{ animationAmount = 2 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
