//
//  AppCoordinator.swift
//  ProManages
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var selectedProject: Project?
    @Published var selectedTask: Task?
    
    func selectProject(_ project: Project) {
        selectedProject = project
    }
    
    func selectTask(_ task: Task) {
        selectedTask = task
    }
}
