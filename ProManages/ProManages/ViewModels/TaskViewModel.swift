//
//  TaskViewModel.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    init() {
        loadTasks()
    }

    func loadTasks() {
        // Пример данных
        self.tasks = [
            Task(id: UUID(), title: "Задача 1", description: "Описание задачи 1", project: Project(id: UUID(), title: "Проект А", description: "Описание проекта А", tasks: []), type: .urgent, difficulty: .medium, importance: .high, startTime: Date(), endTime: Date().addingTimeInterval(3600)),
            Task(id: UUID(), title: "Задача 2", description: "Описание задачи 2", project: Project(id: UUID(), title: "Проект B", description: "Описание проекта B", tasks: []), type: .nonUrgent, difficulty: .easy, importance: .low, startTime: Date(), endTime: Date().addingTimeInterval(7200))
        ]
    }
}

