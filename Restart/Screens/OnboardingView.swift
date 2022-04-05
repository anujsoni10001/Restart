//
//  OnboardingView.swift
//  Restart
//
//  Created by Anuj Soni on 10/03/22.
//

//AsyncImage(url:URL(string:imageURL),transaction: Transaction(animation:.spring(response:0.5, dampingFraction: 0.6, blendDuration: 0.25)))  {phase in
//    switch phase{
//    case .success(let image) : image.ImageModifier()
//.transition(.move(edge:.trailing))
//        //.transition(.slide)
//            .transition(.scale)
//        // No Image is Loaded

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingView = true
    
    @State private var buttonwidth : Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset : CGFloat = 0
    @State private var isAnimating : Bool = false
    @State private var imageOffset:CGSize = .zero
    @State private var indicatorOpacity : Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticfeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        
        ZStack {
            
            // MARK: - color intializer called
            Color("ColorBlue",bundle: nil)
                .ignoresSafeArea(SafeAreaRegions.all, edges:Edge.Set.vertical)
                 
            VStack(spacing:20){
                
                // MARK: - Header
                Spacer()
                
            VStack(spacing:0){
            
                Text(textTitle)
                    .font(Font.system(size:60))
                    .fontWeight(Font.Weight.heavy)
                    .foregroundColor(Color.white)
                    .transition(AnyTransition.opacity)
                    .id(textTitle)
                
                Text("""
                    The main goal of this mini.
                    accomplish with the SwiftUI framework
                    """)
                    .font(Font.title3)
                    .fontWeight(Font.Weight.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(TextAlignment.center)
                    .padding(.horizontal,10)

            }
            .opacity(isAnimating ? 1 : 0)
            .offset(y:isAnimating ? 0 : -40)
            .animation(.easeOut(duration:1), value:isAnimating)
                
                // MARK: - Center
                ZStack{
                 
                    CircleGroupView(ShapeColor: Color.white, ShapeOpacity: 0.2)
                    .offset(x: -imageOffset.width, y: 0)
                    .blur(radius:abs(imageOffset.width/5))
                    .animation(.easeOut(duration: 1), value: imageOffset)
                        
                        
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration:1), value:isAnimating)
                        .offset(x:imageOffset.width * 1.2,y:0)
                        .rotationEffect(.degrees(Double(imageOffset.width)/20))
                        .gesture(
                            DragGesture().onChanged{gesture in
                                if abs(imageOffset.width) <= 150{
                                imageOffset = gesture.translation
                                    withAnimation(.linear(duration: 0.25)){
                                        textTitle = "Give."
                                        indicatorOpacity = 0
                                    }
                                    
                            }
                            }
                            .onEnded{_ in
                                
                                withAnimation(.linear(duration: 0.25)){
                                    textTitle = "Share."
                                    indicatorOpacity = 1
                                }
                                
                                imageOffset = .zero
                            }
                        )
                        .animation(.easeOut(duration: 1), value:imageOffset)
                }
                .overlay(alignment:.bottom){                Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight:.ultraLight, design:.default))
                        .foregroundColor(.white)
                        .offset(y:20)
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 1).delay(2), value:isAnimating)
                        .opacity(indicatorOpacity)
            }
                
                Spacer()
                // MARK: - Footer
                ZStack{
            
                    
                    // MARK: - backgorund
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: 20)
                    
                    // MARK: - capsule dynamic width
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width:80+buttonOffset)
                        
                        Spacer()
                    }
                    // MARK: - circle draggable
                    
                    HStack {
                        ZStack{
                        
                        Circle()
                            .fill(Color("ColorRed"))
                        
                        Circle()
                            .fill(Color.black.opacity(0.15))
                            .padding(8)
            
                            
                        Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                    .frame(width: 80, height: 80,alignment: .center)
                    .offset(x:buttonOffset)
                    .gesture(
                        DragGesture()
                            .onChanged{gesture in
                                if (gesture.translation.width > 0) && (buttonOffset <= (buttonwidth - 80)) {
                                    buttonOffset = gesture.translation.width
                                    
                                }}
                                .onEnded{_ in
                                    withAnimation(Animation.easeOut(duration:0.4)){
                                    if buttonOffset > (buttonwidth/2)  {
                                        buttonOffset = buttonwidth - 80
                                        isOnboardingView = false
                                        playSound(sound:"chimeup", type:"mp3")
                                        hapticfeedback.notificationOccurred(.success)
                                    }else{
                                        hapticfeedback.notificationOccurred(.warning)
                                        buttonOffset = 0
                                    }
                                    }
                                }
                    )
//                    .onTapGesture {
//                        isOnboardingView.toggle()
//                    }
                        
                        Spacer  ()
                    }
                    
                }.frame(width:buttonwidth,height: 80, alignment:.center)
                    .padding()
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y:isAnimating ? 0 : 40)
                    // MARK: - .animation is applied only to views
                    .animation(.easeOut(duration:1), value:isAnimating)
            
                /*Text("OnboardingView")
                    .font(.largeTitle)
                
                // MARK: - 1 Passing Closure in Different Styles
                Button(action:{
                    isOnboardingView.toggle()
                }){
                    Text("Start")
                }*/
            
                
            }
            //VSTACK
        
        }//ZSTACK
        .onAppear{
            isAnimating.toggle()
        }
        .preferredColorScheme(.dark)
            
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
