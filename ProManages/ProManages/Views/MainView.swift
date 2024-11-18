//
//  MainView.swift
//  ProManages
//
//  Created by Artem Vekshin on 11.11.2024.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var currentUser: User? = nil // Состояние для анимации

    var body: some View {
        Group {
            if let user = authViewModel.user {
                if user.role == .admin {
                    ProjectListView()
                } else {
                    TaskListView()
                }
            } else {
                LoginView()
            }
        }
        .onChange(of: authViewModel.user) { newUser in
            withAnimation {
                self.currentUser = newUser // Обновляем состояние для анимации
            }
        }
        .animation(.easeInOut, value: currentUser) // Анимация на изменение currentUser
    }
}

