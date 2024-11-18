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

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authViewModel)
        }
    }
}
