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
