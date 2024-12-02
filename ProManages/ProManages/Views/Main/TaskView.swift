// CreateTaskView.swift
// ProManages
//
// Created by Artem Vekshin on 18.11.2024.
//

import SwiftUI

struct TaskView: View {
    @State private var title: String
    @State private var description: String
    @State private var selectedType: TaskType
    @State private var selectedDifficulty: TaskDifficulty
    @State private var selectedImportance: TaskImportance
    @State private var selectedProject: Project?

    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode

    var task: Taskis?
    var isEditing: Bool {
        task != nil
    }

    init(task: Taskis? = nil) {
        self.task = task
        _title = State(initialValue: task?.title ?? "")
        _description = State(initialValue: task?.description ?? "")
        _selectedType = State(initialValue: task?.type ?? .urgent)
        _selectedDifficulty = State(initialValue: task?.difficulty ?? .medium)
        _selectedImportance = State(initialValue: task?.importance ?? .high)
        _selectedProject = State(initialValue: task?.project)
    }

    var body: some View {
        Form {
            Section(header: Text("Основная информация").font(.headline)) {
                TextField("Название задачи", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)

                TextEditor(text: $description)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
                    .padding(.vertical, 4)
            }

            Section(header: Text("Проект").font(.headline)) {
                Picker("Проект", selection: $selectedProject) {
                    ForEach(taskViewModel.projects, id: \.id) { project in
                        Text(project.title).tag(project as Project?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
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
                if isEditing {
                    if var editedTask = task {
                        editedTask.title = title
                        editedTask.description = description
                        editedTask.type = selectedType
                        editedTask.difficulty = selectedDifficulty
                        editedTask.importance = selectedImportance
                        editedTask.project = selectedProject
                        taskViewModel.updateTask(editedTask)
                    }
                } else {
                    let newTask = Taskis(
                        id: UUID(),
                        title: title,
                        description: description,
                        project: selectedProject,
                        assignedUser: nil,
                        type: selectedType,
                        difficulty: selectedDifficulty,
                        importance: selectedImportance,
                        startTime: Date(),
                        endTime: Date().addingTimeInterval(3600),
                        state: .open
                    )
                    taskViewModel.tasks.append(newTask)
                }
                presentationMode.wrappedValue.dismiss()
            }, title: isEditing ? "Сохранить изменения" : "Создать задачу")
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

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TaskViewModel())
    }
}
