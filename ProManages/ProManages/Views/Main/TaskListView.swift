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
    @State private var showingCreateTaskSheet = false

    var body: some View {
        List(taskViewModel.tasks) { task in
            TaskRowView(task: task)
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
                    showingCreateTaskSheet = true
                }) {
                    Label("Создать задачу", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingCreateTaskSheet) {
            CreateTaskView()
                .environmentObject(taskViewModel)
        }
        .gradientBackground()
    }
}

