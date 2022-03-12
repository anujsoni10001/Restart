//
//  HomeView.swift
//  Restart
//
//  Created by Anuj Soni on 10/03/22.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingView = false
    @State private var isAnimating:Bool = false
   
    
    var body: some View {
        
        
        VStack(spacing:20){
            
        Spacer()
            
       // MARK: - header
            ZStack {
                
            CircleGroupView(ShapeColor: Color.gray, ShapeOpacity: 0.1)
                
                Image("character-2")
                .resizable()
                .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(.easeOut(duration:4)
                            .repeatForever(), value:isAnimating)
            }
        
            
       // MARK: - center
            Text("""
                The main goal of this mini.
                accomplish with the SwiftUI framework
                """)
                .font(Font.title3)
                .fontWeight(Font.Weight.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(TextAlignment.center)
                .padding()
            
       // MARK: - footer
        Spacer()
        

//         MARK: -2 Passing Closure in Different Styles
        Button{
            withAnimation{
            playSound(sound:"success", type:"m4a")
            isOnboardingView = true
            }
            
        } label:{
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
            
                Text("Restart")
                    .font(Font.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { isAnimating = true})
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
