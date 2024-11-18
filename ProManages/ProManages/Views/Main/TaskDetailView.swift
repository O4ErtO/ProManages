//
//  TaskDetailView.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

struct TaskDetailView: View {
    let task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title).font(.title)
            Text(task.description)
            HStack {
                Text("Difficulty: \(task.difficulty.rawValue)")
                Text("Importance: \(task.importance.rawValue)")
            }
            .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
    }
}
//#Preview {
//    TaskDetailView(task: Task(id: UUID(), title: "Test", description: "Test", difficulty: TaskDifficulty(rawValue: TaskDifficulty.easy.rawValue) ?? TaskDifficulty.easy, importance: TaskImportance(rawValue: TaskImportance.high.rawValue) ?? TaskImportance.high))
//}
