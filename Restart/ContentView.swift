//
//  ContentView.swift
//  Restart
//
//  Created by Anuj Soni on 10/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingView = true
    
var body: some View {
    
    ZStack {
        
        if isOnboardingView{
            OnboardingView()
        }else{
            HomeView()
        }

    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
