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

    init() {
        loadUser()
    }

    func performLogin() async throws -> Bool {
        do {
            let response = try await supabaseClient.auth.signIn(email: login, password: password)
            let authUser = response.user
            let profile = try await getProfile(for: authUser)
            let userModel = User(id: authUser.id.uuidString, email: authUser.email ?? "", username: profile.username ?? "", password: "", role: Role(rawValue: profile.role ?? "worker") ?? .worker)
            DispatchQueue.main.async {
                self.user = userModel
                UserManager.shared.currentUser = userModel
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
                    UserManager.shared.currentUser = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Не удалось выполнить выход: \(error.localizedDescription)"
                }
            }
        }
    }

    private func loadUser() {
        self.user = UserManager.shared.currentUser
    }

    private func getProfile(for user: Auth.User) async throws -> Profile {
        let response: PostgrestResponse<[Profile]> = try await supabaseClient.database.from("users").select().eq("id", value: user.id.uuidString).execute()
        guard let profile = response.value.first else {
            throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])
        }
        return profile
    }
}
