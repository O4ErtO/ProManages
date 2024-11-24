//
//  ProManagesApp.swift
//  ProManages
//
//  Created by Artem Vekshin on 07.11.2024.
//

import SwiftUI
import SwiftData

@main
struct ProManagesApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authViewModel)
                .environmentObject(appState)
                .onAppear {
                    disableTabbing()
                }
        }
    }
}


func disableTabbing() {
    if let window = NSApplication.shared.windows.first {
        window.tabbingMode = .disallowed
    }
}
