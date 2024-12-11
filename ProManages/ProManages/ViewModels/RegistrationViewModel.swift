//
//  RegistrationViewModel.swift
//  ProManages
//
//  Created by Artem Vekshin on 28.11.2024.
//

import Foundation
import Combine
import Supabase

class RegistrationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var role: Role = .worker
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    private var cancellables = Set<AnyCancellable>()
    private let supabaseClient = SupabaseClients.shared.client

    func registerUser() async {
        do {
            let response = try await supabaseClient.auth.signUp(email: email, password: password)
            if let session = response.session {
                let newUser = User(id: session.user.id.uuidString, email: email, username: username, password: password, role: role)
                try await supabaseClient.database.from("users").insert(newUser.asDictionary).execute()
            }
        } catch {
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertMessage = error.localizedDescription
            }
        }
    }
}

extension User {
    var asDictionary: Encodable {
        return [
            "id": id,
            "email": email,
            "username": username,
            "password": password,
            "role": role.rawValue
        ]
    }
}

