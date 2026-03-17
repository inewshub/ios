//
//  DashboardView.swift
//  inewshub
//
//  Created by seevsk on 12/10/25.
//

import SwiftUI
import SwiftData


struct DashboardView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Circle()
                .fill(Color("bg-color"))
                .scaleEffect(2.4)
                .offset(x: -150, y: -580)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 60)
                    
                    Spacer()
                    
                    Button(action: {
                        // acción del botón menú
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, -12)
                
                Spacer()
                
                TabView(selection: $selectedTab) {
                    NavigationStack {
                        AllView()
                    }
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                    NavigationStack {
                        FavoritesView()
                    }
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    .tag(1)
                    
                    NavigationStack {
                        UsersView()
                               .environmentObject(UsersApiManager())
                       }
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(2)
                    
                    NavigationStack {
                        OptionsView()
                    }
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(3)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
