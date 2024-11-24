// CreateTaskView.swift
// ProManages
//
// Created by Artem Vekshin on 18.11.2024.
//

import SwiftUI

struct CreateTaskView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedType: TaskType = .urgent
    @State private var selectedDifficulty: TaskDifficulty = .medium
    @State private var selectedImportance: TaskImportance = .high

    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Основная информация").font(.headline)) {
                TextField("Название задачи", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)
                TextField("Описание задачи", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)
            }

            Section(header: Text("Тип задачи").font(.headline)) {
                Picker("Тип", selection: $selectedType) {
                    Text("Срочная").tag(TaskType.urgent)
                    Text("Не срочная").tag(TaskType.nonUrgent)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 4)
            }

            Section(header: Text("Сложность").font(.headline)) {
                Picker("Сложность", selection: $selectedDifficulty) {
                    Text("Легкая").tag(TaskDifficulty.easy)
                    Text("Средняя").tag(TaskDifficulty.medium)
                    Text("Трудная").tag(TaskDifficulty.hard)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 4)
            }

            Section(header: Text("Срочность").font(.headline)) {
                Picker("Срочность", selection: $selectedImportance) {
                    Text("Низкая").tag(TaskImportance.low)
                    Text("Средняя").tag(TaskImportance.medium)
                    Text("Высокая").tag(TaskImportance.high)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 4)
            }

            GradientButton(action: {
                let newTask = Task(
                    id: UUID(),
                    title: title,
                    description: description,
                    project: Project(id: UUID(), title: "Проект А", description: "Описание проекта А", tasks: []),
                    assignedUser: nil,
                    type: selectedType,
                    difficulty: selectedDifficulty,
                    importance: selectedImportance,
                    startTime: Date(),
                    endTime: Date().addingTimeInterval(3600)
                )
                taskViewModel.tasks.append(newTask)
                presentationMode.wrappedValue.dismiss()
            }, title: "Создать задачу")
            .padding(.vertical, 16)
        }
        .padding()
        .frame(minWidth: 400, minHeight: 500)
        .gradientBackground()
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
            .environmentObject(TaskViewModel())
    }
}
