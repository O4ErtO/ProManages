//
//  TaskListView.swift
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

struct TaskListView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @StateObject var projectViewModel = ProjectViewModel()
    @EnvironmentObject private var appState: AppState
    @State private var selectedProject: Project?
    @State private var showingTaskSheet = false
    @State private var editingTask: Taskis? = nil

    var body: some View {
        List(taskViewModel.tasks.filter { $0.projectId == selectedProject?.id }) { task in
            TaskRowView(task: task, onEdit: {
                editingTask = task
                showingTaskSheet = true
            }, onDelete: {
                Task {
                    await taskViewModel.deleteTask(task)
                }
            })
            .onTapGesture {
                appState.push(.taskDetails(task))
            }
        }
        .scrollContentBackground(.hidden)
        .gradientBackground()
        .navigationTitle(selectedProject?.title ?? "Tasks")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    editingTask = nil
                    showingTaskSheet = true
                }) {
                    Label("Создать задачу", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingTaskSheet) {
            TaskView(task: editingTask)
                .environmentObject(taskViewModel)
                .environmentObject(projectViewModel)
        }
        .gradientBackground()
        .onAppear {
            Task {
                await taskViewModel.fetchTasks()
                await projectViewModel.fetchProjects()
                if let firstProject = projectViewModel.projects.first {
                    selectedProject = firstProject
                }
            }
        }
        .onChange(of: appState.currentRoute) { newValue in
            if case let .showTask(project) = newValue {
                selectedProject = project
            }
        }
    }
}
