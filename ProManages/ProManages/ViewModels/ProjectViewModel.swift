//
//  ProjectViewModel.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    
    init() {
        loadProjects()
    }
    
    func loadProjects() {
        self.projects = [
            Project(id: UUID(), title: "Project 1", description: "Description 1", tasks: [Task(id: UUID(), title: "Test", description: "Test", type: TaskType.urgent, difficulty: TaskDifficulty.hard, importance: TaskImportance.low)]),
        ]
    }
}
