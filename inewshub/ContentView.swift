//
//  ContentView.swift
//  inewshub
//
//  Created by seevsk on 1/10/25.
//

import SwiftUI

struct OnboardingPage {
    let title: String
    let image: String
    let buttonText: String
}

struct ContentView: View {
    @State private var currentPage = 0
    @State private var goToRegister = false
    
    let pages = [
        OnboardingPage(
            title: String(localized: "obng_title_1"),
            image: "onboarding1",
            buttonText: String(localized: "obng_btn_1")
        ),
        OnboardingPage(
            title: String(localized: "obng_title_2"),
            image: "onboarding2",
            buttonText: String(localized: "obng_btn_2")
        ),
        OnboardingPage(
            title: String(localized: "obng_title_3"),
            image: "onboarding3",
            buttonText: String(localized: "obng_btn_3")
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Circle()
                        .fill(Color("bg-color"))
                        .scaleEffect(2.0)
                        .offset(x: 180, y: -160)
                        .ignoresSafeArea()
                    Spacer()
                }
                
                VStack(alignment: .trailing, spacing: 8) {
                               HStack(spacing: 0) {
                                   Image("logo")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 125, height: 40)
                               }

                               Text(pages[currentPage].title)
                                   .font(.title)
                                   .bold()
                                   .foregroundColor(.white)
                                   .multilineTextAlignment(.trailing)
                                   .frame(maxWidth: 350, alignment: .trailing)
                           }
                           .padding(.top, 40)
                           .padding(.trailing, 20)
                           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
                VStack {
                 

                    Image(pages[currentPage].image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 290)
                        .padding(.top, 200)
                    
                    Spacer()
        
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Button {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    currentPage = index
                                }
                            } label: {
                                Circle()
                                    .fill(index == currentPage ? Color("black") : Color.gray.opacity(0.4))
                                    .frame(width: index == currentPage ? 20 : 20,
                                           height: index == currentPage ? 20 : 20)
                                    .animation(.easeInOut, value: currentPage)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 30)
                    
                    
                    
                    StartButton(title: pages[currentPage].buttonText) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                        if currentPage < pages.count - 1 {
                            currentPage += 1
                        } else {
                            goToRegister = true
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(Color("black"))
                        .fontWeight(.medium)
                        .font(.system(size: 20))

                        NavigationLink(destination: LoginView()) {
                                        Text("Login")
                                            .font(.system(size: 21))
                                            .foregroundColor(Color("ancore-color"))
                                            .bold()
                                    }
                                }
                                .font(.footnote)
                                .padding(.bottom, 40)
                                .frame(width: 320, height: 60)
                    
                    
                    NavigationLink("", destination: RegisterView(), isActive: $goToRegister)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
