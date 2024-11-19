//
//  TaskRowView.swift
//  ProManages
//
//  Created by Artem Vekshin on 18.11.2024.
//

import Foundation
import SwiftUI

struct TaskRowView: View {
    let task: Task

    var body: some View {
        HStack {
            Circle()
                .fill(task.urgencyColor)
                .frame(width: 10, height: 10)
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text("Описание: \(task.description)")
                    .font(.subheadline)
                Text("Тип: \(task.type.rawValue)")
                    .font(.subheadline)
                Text("Сложность: \(task.difficulty.rawValue)")
                    .font(.subheadline)
                Text("Срочность: \(task.importance.rawValue)")
                    .font(.subheadline)
                Text("Проект: \(task.project!.title)")
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
