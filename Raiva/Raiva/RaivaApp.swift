//
//  RaivaApp.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import SwiftUI

@main
struct RaivaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppData())
        }
    }
}
