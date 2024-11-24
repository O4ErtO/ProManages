//
//  MainView.swift
//  ProManages
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject private var appState: AppState
    @State private var currentUser: User? = nil

    var body: some View {
            if let user = authViewModel.user {
                ProjectListSideBarView()
                
            } else {
                LoginView()
            }
    }
}

