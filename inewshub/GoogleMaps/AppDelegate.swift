//
//  AppDelegate.swift
//  inewshub
//
//  Created by seevsk on 23/11/25.
//

import Foundation
import GoogleMaps

class AppDelegate:UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyC8apA-LjTstKCMiOhdQVxN4_nYHPnr_EA")
        return true
    }
}
