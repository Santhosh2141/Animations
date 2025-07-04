//
//  ContentView.swift
//  Animations
//
//  Created by Santhosh Srinivas on 13/06/25.
//

import SwiftUI

// this creates a custom animation. we create this animation.
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
        // having clipped makes the box wipe the yellow box
        // if there is no clipped, the grey box stays above the yellow box and then wipes into the yellow box
            .clipped()
    }
}
// so like .scale, we can add this .pivot to perform any transition
extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}
struct ContentView: View {
    
    @State private var animationAmount = 1.0
    
    @State private var animationValue = 0.0
    
    @State private var enabled = false
    
    @State private var dragAmount = CGSize.zero // CGSize is coreGraphocs
    
    let stringLetters = Array("Hello SwiftUI")
    @State private var enable = false
    @State private var dragValue = CGSize.zero
    
    @State private var isShowingRed = true
    
    @State private var showingGrey = false
    var body: some View {
        
//        print(animationAmount)
        
        // as we have some non view code "print" we have to return te VSTACK
        return ZStack{
            Rectangle()
                .fill(.yellow)
                .frame(width: 200, height: 200)
            
            if showingGrey{
                Rectangle()
                    .fill(.gray)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
            VStack{
                
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: 300, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged{ dragAmount = $0.translation }
                                    .onEnded{ _ in
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
                                            dragAmount = .zero

                                        }
                                        // This is EXPLICIT ANIMATION. the item follows finger immediately.
                                    }
                            )
                            // This lets us drag the items anywhere. onChanged will update the drag amount by x and y coordinates. onEnded resets it back to 0
    //                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: dragAmount)
                // this animation makes the release smooth. IMPLICIT ANIMATION. has a lag w finger
                
                
                Stepper("Scale Amount", value: $animationAmount.animation(), in: 1...10)
                
                HStack() {
                    ForEach(0..<stringLetters.count, id: \.self){ letter in
                        Text(String(stringLetters[letter]))
                            .padding(5)
                            .font(.title)
                            .background(enable ? .blue : .red)
                            .offset(dragValue)
                            .animation(.linear.delay(Double(letter)/20), value: dragValue)
                    }
                }
                .gesture(
                    DragGesture()
                    .onChanged{ dragValue = $0.translation }
                    .onEnded{ _ in
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
                            dragValue = .zero
                            enable.toggle()
                        }
                    }
                )
                
                Button("Tap Me"){
                    withAnimation{
                        isShowingRed.toggle()
                    }
                }
                if isShowingRed{
                    Rectangle()
                        .fill(.red)
                        .frame(width: 100, height: 100)
    //                    .transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
                
    //            Spacer()
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
                
                Button("Toggle Me"){
                        enabled.toggle()
                }
                .frame(width: 100, height: 100)
                .background(enabled ? .blue : .red)
                .foregroundColor(.white)
                .animation(nil, value: enabled)
                // an animation of nil means the above stuff should happen immediately
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 40 : 0))
                .animation(.spring(response: 1, dampingFraction: 0.1), value: enabled)
                
    //            Spacer()
                Button("Tap Me") {
                    animationAmount += 1
                }
                .padding(40)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
            }
        }
        .onTapGesture {
            withAnimation{
                showingGrey.toggle()
            }
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
