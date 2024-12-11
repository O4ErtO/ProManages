//
//  UserManager.swift
//  ProManages
//
//  Created by Artem Vekshin on 09.12.2024.
//

import Foundation


class UserManager {
    static let shared = UserManager()

    private init() {}

    var currentUser: User? {
        didSet {
            NotificationCenter.default.post(name: .userDidChange, object: nil)
        }
    }
}

extension Notification.Name {
    static let userDidChange = Notification.Name("userDidChange")
}
