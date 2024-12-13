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
    @State private var showingTaskSheet = false
    @State private var editingTask: Taskis? = nil
    @State private var isLoading = false
    @State var selectedProject: Project

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                List(taskViewModel.tasks.filter { $0.projectId == selectedProject.id }) { task in
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
                .navigationTitle(selectedProject.title)
                .toolbar {
                    if appState.currentUser?.role == .admin {
                        ToolbarItem(placement: .primaryAction) {
                            Button(action: {
                                editingTask = nil
                                showingTaskSheet = true
                            }) {
                                Label("Создать задачу", systemImage: "plus")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingTaskSheet) {
                    TaskView(task: editingTask)
                        .environmentObject(taskViewModel)
                        .environmentObject(projectViewModel)
                }
                .gradientBackground()
            }
        }
        .onAppear {
            loadTasks()
        }
        .onChange(of: appState.currentRoute) { newValue in
            if case let .showTask(project) = newValue {
                selectedProject = project
                loadTasks()
            }
        }
    }

    private func loadTasks() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Task {
                await taskViewModel.fetchTasks(for: selectedProject)
                isLoading = false
            }
        }
    }
}
