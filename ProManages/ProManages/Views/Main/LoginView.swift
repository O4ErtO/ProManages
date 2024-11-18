//
//  LoginView.swift
//  ProManages
//
//  Created by Artem Vekshin on 18.11.2024.
//


import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showError: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Вход")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            TextField("Имя пользователя", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            SecureField("Пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            Button(action: {
                if !authViewModel.login(username: username, password: password) {
                    showError = true
                }
            }) {
                Text("Войти")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $showError) {
                Alert(title: Text("Ошибка"), message: Text("Неверное имя пользователя или пароль"), dismissButton: .default(Text("Ок")))
            }

            Button(action: {
                // Логика для перехода на регистрацию
            }) {
                Text("Регистрация")
            }
            .padding(.top, 10)
        }
        .padding()
    }
}
