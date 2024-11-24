//
//  Created by Artem Vekshin on 18.11.2024.
//


import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var login: String = ""
    @Published var password: String = ""

    func performLogin() -> Bool { 
        if login == "admin" && password == "1234" {
            user = User(username: login, role: .admin)
            return true
        } else if login == "worker" && password == "1234" {
            user = User(username: login, role: .worker)
            return true
        }
        return false
    }

    func logout() {
        user = nil
    }
}
