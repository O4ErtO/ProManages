//
//  LoginView.swift
//  ProManages
//
//  Created by Artem Vekshin on 18.11.2024.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showError: Bool = false
    @State private var showSheet: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 25) {
                Text("Добро пожаловать!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10)

                TextField("", text: $authViewModel.login)
                    .placeholder("Имя пользователя", when: authViewModel.login.isEmpty)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.8)))
                    .shadow(radius: 5)
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .textFieldStyle(PlainTextFieldStyle())
                    .disableAutocorrection(true)

                SecureField("", text: $authViewModel.password)
                    .placeholder("Пароль", when: authViewModel.password.isEmpty)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.8)))
                    .shadow(radius: 5)
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .textFieldStyle(PlainTextFieldStyle())
                    .disableAutocorrection(true)

                GradientButton(
                    action: loginAction,  
                    title: "Вход"
                )
                .padding(.horizontal, 30)

                Button(action: {
                    showSheet.toggle()
                }) {
                    Text("Нет аккаунта? Зарегистрируйтесь")
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            RegistrationView(viewModel: RegistrationViewModel())
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Ошибка"), message: Text("Неверное имя пользователя или пароль"), dismissButton: .default(Text("Ок")))
        }
    }

    func loginAction() {
        Task {
            do {
                let success = try await authViewModel.performLogin() // Добавляем try для обработки ошибок
                if !success {
                    showError = true
                }
            } catch {
                showError = true
            }
        }
    }

}
