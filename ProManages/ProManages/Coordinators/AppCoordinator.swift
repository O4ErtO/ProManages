//
//  AppCoordinator.swift
//  ProManages
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

import Foundation

enum Route: Codable, Equatable {
    case showTask(Project)
    case taskDetails(Taskis)
    case statistic

    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case let (.showTask(lhsProject), .showTask(rhsProject)):
            return lhsProject.id == rhsProject.id
        case let (.taskDetails(lhsTask), .taskDetails(rhsTask)):
            return lhsTask.id == rhsTask.id
        case (.statistic, .statistic):
            return true
        default:
            return false
        }
    }
}


import SwiftUI

class AppState: ObservableObject {
    @Published var routes: [Route] = []
    @Published var currentUser: User?

    var currentRoute: Route? {
        routes.last
    }

    private var userObserver: NSObjectProtocol?

    init() {
        loadUser()
        userObserver = NotificationCenter.default.addObserver(forName: .userDidChange, object: nil, queue: .main) { [weak self] _ in
            self?.loadUser()
        }
    }

    deinit {
        if let observer = userObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    func push(_ route: Route) {
        routes.append(route)
    }

    @discardableResult
    func pop() -> Route? {
        routes.popLast()
    }

    private func loadUser() {
        self.currentUser = UserManager.shared.currentUser
    }
}
