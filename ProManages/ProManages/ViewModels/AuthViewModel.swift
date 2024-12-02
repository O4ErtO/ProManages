//
//  Created by Artem Vekshin on 18.11.2024.
//


import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var login: String = ""
    @Published var password: String = ""

    func performLogin() async -> Bool {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: login, password: password)
            let firebaseUser = authResult.user

            let role: Role = (login == "admin@example.com") ? .admin : .worker

            self.user = User(
                id: firebaseUser.uid,
                email: firebaseUser.email ?? "",
                username: firebaseUser.displayName ?? "No Name",
                role: role
            )

            return true
        } catch {
            print("Ошибка авторизации: \(error.localizedDescription)")
            return false
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch let signOutError as NSError {
            print("Ошибка выхода: \(signOutError.localizedDescription)")
        }
    }
}
