//
//  AppCoordinator.swift
//  ProManages
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

enum Route {
    case showTask(Project)
    case taskDetails(Taskis)
    case statistic
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []

    var currentRoute: Route? {
        routes.last
    }

    func push(_ route: Route) {
        routes.append(route)
    }

    @discardableResult
    func pop() -> Route? {
        routes.popLast()
    }
}
