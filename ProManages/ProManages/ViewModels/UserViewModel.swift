//
//  UserViewModel.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func assignTask(_ task: Task, to user: User) {
    }
}
