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

    @State private var newProjectTitle: String = ""
    @State private var isCreatingNewProject: Bool = false

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
        _selectedProject = State(initialValue: nil) // Initialize to nil, will be set in onAppear
    }

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

            Section(header: Text("Проект").font(.headline)) {
                if isCreatingNewProject {
                    TextField("Название нового проекта", text: $newProjectTitle)
                } else {
                    Picker("Выберите проект", selection: $selectedProject) {
                        ForEach(taskViewModel.projects, id: \.id) { project in
                            Text(project.title).tag(project as Project?)
                        }
                    }
                }
                Toggle("Создать новый проект", isOn: $isCreatingNewProject)
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
                saveTask()
            }, title: isEditing ? "Сохранить изменения" : "Создать задачу")
            .padding(.vertical, 16)
        }
        .padding()
        .frame(minWidth: 400, minHeight: 500)
        .gradientBackground()
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .onAppear {
            Task {
                await taskViewModel.fetchProjects()
                if let task = task {
                    selectedProject = taskViewModel.projects.first { $0.id == task.projectId }
                }
            }
        }
    }

    private func saveTask() {
        Task {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            // Получаем идентификатор пользователя из UserDefaults
            let userId = UUID(uuidString: UserDefaults.standard.string(forKey: "userId") ?? "") ?? UUID()

            let newTask = Taskis(
                id: task?.id ?? UUID(),
                title: title,
                description: description,
                projectId: selectedProject?.id ?? UUID(),
                assignedUserId: userId,
                type: selectedType,
                difficulty: selectedDifficulty,
                importance: selectedImportance,
                startTime: formatter.string(from: Date()),
                endTime: formatter.string(from: Date().addingTimeInterval(3600)),
                state: task?.state ?? .open
            )

            if isCreatingNewProject {
                let newProject = Project(id: UUID(), title: newProjectTitle, description: "")
                await taskViewModel.addProject(newProject)
                selectedProject = newProject
            }

            if isEditing {
                await taskViewModel.updateTask(newTask)
            } else {
                await taskViewModel.addTask(newTask)
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
}
