//
//  User.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

struct User: Codable, Identifiable, Hashable, Equatable {
    var id: String
    var email: String
    var username: String
    var password: String
    var role: Role

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.email == rhs.email && lhs.username == rhs.username && lhs.role == rhs.role
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(email)
        hasher.combine(username)
        hasher.combine(role)
    }
}

enum Role: String, Codable {
    case admin
    case worker
}
