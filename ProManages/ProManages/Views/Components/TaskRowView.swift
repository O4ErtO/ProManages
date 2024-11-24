// TaskRowView.swift
//
// Created by Artem Vekshin on 18.11.2024.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task

    var body: some View {
        HStack {
            // Urgency indicator circle
            Circle()
                .fill(task.urgencyColor)
                .frame(width: 16, height: 16)
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 4) {
                // Title of the task with bold and larger font
                Text(task.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                // Description of the task with smaller font
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .padding(.vertical, 2)

                HStack(spacing: 8) {
                    // Type of task
                    TaskAttributeView(title: "Тип", value: task.type.rawValue, color: nil)

                    // Difficulty of the task
                    TaskAttributeView(title: "Сложность", value: task.difficulty.rawValue, color: task.difficultyColor)

                    // Urgency level of the task
                    TaskAttributeView(title: "Срочность", value: task.importance.rawValue, color: task.urgencyColor)

                    // Project name associated with the task
                    if let project = task.project {
                        TaskAttributeView(title: "Проект", value: project.title, color: nil)
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)

            Spacer()
        }
        .padding(.horizontal, 16)
        .gradientBackground()
        .cornerRadius(20)
        .padding(.vertical, 4)
    }
}


