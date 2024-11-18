//
//  TaskListView.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(taskViewModel.tasks) { task in
                    TaskRowView(task: task)
                }
            }
            .frame(minWidth: 600, minHeight: 400)
            .toolbar {
                if authViewModel.user?.role == .admin {
                    ToolbarItem {
                        Button(action: {
                             print("Создать задачу")
                        }) {
                            Label("Создать задачу", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }
}

