//
//  Created by Artem Vekshin on 18.11.2024.
//


import Foundation
import Combine
import Supabase

class AuthViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var user: User? = nil
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let supabaseClient = SupabaseClients.shared.client

    func performLogin() async throws -> Bool {
        do {
            let response = try await supabaseClient.auth.signIn(email: login, password: password)
            let users = response.user
            DispatchQueue.main.async {
                self.user = User(id: users.id.uuidString, email: users.email ?? "", username: users.userMetadata["username"] as? String ?? "", password: self.user?.password ?? "", role: .worker)
                UserDefaults.standard.set(users.id.uuidString, forKey: "userId")

            }
            return true
        } catch let error as NSError {
            if error.code == 400 {
                DispatchQueue.main.async {
                    self.errorMessage = "Неверные учетные данные. Пожалуйста, проверьте свой логин и пароль."
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Не удалось выполнить вход: \(error.localizedDescription)"
                }
            }
            throw error
        }
    }

    func logout() {
        Task {
            do {
                try await supabaseClient.auth.signOut()
                DispatchQueue.main.async {
                    self.user = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Не удалось выполнить выход: \(error.localizedDescription)"
                }
            }
        }
    }
}
