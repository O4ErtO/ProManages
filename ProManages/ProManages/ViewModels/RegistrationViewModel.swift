//
//  RegistrationViewModel.swift
//  ProManages
//
//  Created by Artem Vekshin on 28.11.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var role: Role = .worker
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func registerUser() async {
        guard password == confirmPassword else {
            alertMessage = "Пароли не совпадают"
            showAlert = true
            return
        }

        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authResult.user

            let db = Firestore.firestore()
            try await db.collection("users").document(user.uid).setData([
                "username": self.username,
                "email": self.email,
                "role": self.role.rawValue
            ])
        } catch {
            alertMessage = "Ошибка регистрации: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
