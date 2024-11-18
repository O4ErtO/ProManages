//
//  TaskTimerView.swift
//  ProManages
//
//  Created by Artem Vekshin on 18.11.2024.
//

import Foundation
import SwiftUI

struct TaskTimerView: View {
    let task: Task
    @State private var startTime: Date = Date()
    @State private var isRunning: Bool = false

    var body: some View {
        VStack {
            Text("Задача: \(task.title)")
                .font(.title)
            Text("Описание: \(task.description)")

            if isRunning {
                Text("Время: \(Date().timeIntervalSince(startTime), specifier: "%.0f") секунд")
            }

            Button(action: {
                if isRunning {
                    // Остановить таймер
                    isRunning = false
                } else {
                    // Запустить таймер
                    startTime = Date()
                    isRunning = true
                }
            }) {
                Text(isRunning ? "Остановить" : "Запустить")
                    .padding()
                    .background(isRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
