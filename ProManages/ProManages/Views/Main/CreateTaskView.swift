//
//  CreateTaskView.swift
//  ProManages
//
//  Created by Artem Vekshin on 18.11.2024.
//

import Foundation
import SwiftUI

struct CreateTaskView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedType: TaskType = .urgent
    @State private var selectedDifficulty: TaskDifficulty = .medium
    @State private var selectedImportance: TaskImportance = .high

    @EnvironmentObject var taskViewModel: TaskViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Form {
            Section(header: Text("Основная информация")) {
                TextField("Название задачи", text: $title)
                TextField("Описание задачи", text: $description)
            }

            Section(header: Text("Тип задачи")) {
                Picker("Тип", selection: $selectedType) {
                    Text("Срочная").tag(TaskType.urgent)
                    Text("Не срочная").tag(TaskType.nonUrgent)
                }
            }

            Section(header: Text("Сложность")) {
                Picker("Сложность", selection: $selectedDifficulty) {
                    Text("Легкая").tag(TaskDifficulty.easy)
                    Text("Средняя").tag(TaskDifficulty.medium)
                    Text("Трудная").tag(TaskDifficulty.hard)
                }
            }

            Section(header: Text("Срочность")) {
                Picker("Срочность", selection: $selectedImportance) {
                    Text("Низкая").tag(TaskImportance.low)
                    Text("Средняя").tag(TaskImportance.medium)
                    Text("Высокая").tag(TaskImportance.high)
                }
            }

            Button("Создать задачу") {
                // Добавление задачи
                let newTask = Task(id: UUID(), title: title, description: description, project: Project(id: UUID(), title: "Проект А", description: "Описание проекта А", tasks: []), assignedUser: nil, type: selectedType, difficulty: selectedDifficulty, importance: selectedImportance, startTime: Date(), endTime: Date().addingTimeInterval(3600))
                taskViewModel.tasks.append(newTask)
            }
        }
        .navigationTitle("Создание задачи")
    }
}
