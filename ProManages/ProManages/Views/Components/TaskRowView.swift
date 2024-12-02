// TaskRowView.swift
//
// Created by Artem Vekshin on 18.11.2024.
//


import SwiftUI

struct TaskRowView: View {
    let task: Taskis
    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?

    var body: some View {
        HStack {
            Circle()
                .fill(task.urgencyColor)
                .frame(width: 16, height: 16)
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .padding(.vertical, 2)

                HStack(spacing: 8) {
                    TaskAttributeView(title: "", value: task.type.rawValue, color: nil)
                        .padding(6)
                        .background(.purple)
                        .cornerRadius(14)
                    
                    TaskAttributeView(title: "Сложность", value: task.difficulty.rawValue, color: task.difficultyColor)
                    TaskAttributeView(title: "Срочность", value: task.importance.rawValue, color: task.urgencyColor)

                    if let project = task.project {
                        TaskAttributeView(title: "Проект", value: project.title, color: nil)
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)

            Spacer()

            HStack(spacing: 10) {
                if let onEdit = onEdit {
                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }

                if let onDelete = onDelete {
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .gradientBackground()
        .cornerRadius(20)
        .padding(.vertical, 4)
    }
}
