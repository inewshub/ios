//
//  LaunchScreen.swift
//  inewshub
//
//  Created by seevsk on 1/10/25.
//

import SwiftUI

struct LaunchScreen: View {
    @Binding var showIntro: Bool
    @State private var startAnimation = false
    var body: some View {
        ZStack{
            Color("bg-color")
                            .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .scaleEffect(startAnimation ? 1.0 : 3.0)
                .opacity(startAnimation ? 1.0 : 0.0)
                .offset(y: startAnimation ? 0 : 1000)
        }
        .ignoresSafeArea()
        .onAppear{
            withAnimation(.easeOut(duration: 2.0)){
                startAnimation = true
            }
        
            Task{
                try? await Task.sleep(for: .seconds(5))
                withAnimation{
                    showIntro = false
                }
            }
        }
    }
}

#Preview {
    LaunchScreen(showIntro: .constant(true))
}
