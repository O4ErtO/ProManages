//
//  User.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

enum Role {
    case admin
    case worker
}

struct User: Equatable {
    let username: String
    let role: Role
}
