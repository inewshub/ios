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
    @StateObject var apiManager = UsersApiManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ArticleDetailView(articleSlug: "un-climate-session-geneva")
            }
            .environmentObject(apiManager)
        }.modelContainer(for: NewsLocal.self)
    }
}
