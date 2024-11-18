//
//  Created by Artem Vekshin on 18.11.2024.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil

    func login(username: String, password: String) -> Bool {
        if username == "admin" && password == "1234" {
            user = User(username: username, role: .admin)
            return true
        } else if username == "worker" && password == "1234" {
            user = User(username: username, role: .worker)
            return true
        }
        return false
    }

    func logout() {
        user = nil
    }
}
