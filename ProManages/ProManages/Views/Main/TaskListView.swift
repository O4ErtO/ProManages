//
//  TaskListView.swift
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

struct TaskListView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @EnvironmentObject private var appState: AppState
    let project: Project
    @State private var showingTaskSheet = false
    @State private var editingTask: Taskis? = nil

    var body: some View {
        List(taskViewModel.tasks) { task in
            TaskRowView(task: task, onEdit: {
                editingTask = task
                showingTaskSheet = true
            }, onDelete: {
                taskViewModel.deleteTask(task)
            })
                .onTapGesture {
                    appState.push(.taskDetails(task))
                }
        }
        .scrollContentBackground(.hidden)
        .gradientBackground()
        .navigationTitle(project.title)
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
        }
        .gradientBackground()
    }
}
