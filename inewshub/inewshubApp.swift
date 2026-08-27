//
//  inewshubApp.swift
//  inewshub
//
//  Created by seevsk on 1/10/25.
//

import SwiftUI
import SwiftData

@main
struct inewshubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showIntro = true
    @StateObject var apiManager = UsersApiManager()

    var body: some Scene {
        WindowGroup {
            ZStack {
                if !showIntro {
                    ContentView()
                        .environmentObject(apiManager)
                }
                if showIntro {
                    LaunchScreen(showIntro: $showIntro)
                        .transition(.opacity)
                        .environmentObject(apiManager)
                }
            }
        }.modelContainer(for: NewsLocal.self)
    }
}
