//
//  RegisterView.swift
//  ProManages
//
//  Created by Artem Vekshin on 28.11.2024.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding(20)
                    }
                    Spacer()
                }

                Text("Регистрация")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.bottom, 20)

                VStack(spacing: 15) {
                    TextField("", text: $viewModel.username)
                        .placeholder("Имя пользователя", when: viewModel.username.isEmpty)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.8)))
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)

                    TextField("", text: $viewModel.email)
                        .placeholder("Электронная почта", when: viewModel.email.isEmpty)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.8)))
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)

                    SecureField("Пароль", text: $viewModel.password)
                        .placeholder("Пароль", when: viewModel.password.isEmpty)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.8)))
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)

                    SecureField("Подтвердите пароль", text: $viewModel.confirmPassword)
                        .placeholder("Подтвердите пароль", when: viewModel.password.isEmpty)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.8)))
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)

                    Picker("Роль", selection: $viewModel.role) {
                        Text("Админ").tag(Role.admin)
                        Text("Воркер").tag(Role.worker)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 30)
                }

                Button(action: {
                    Task {
                        await viewModel.registerUser()
                    }
                }) {
                    Text("Зарегистрироваться")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .buttonStyle(.plain)
                        .background(Color.blue)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 30)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Ошибка"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("ОК")))
                }
            }
            .padding()
        }.gradientBackground()
    }
}
