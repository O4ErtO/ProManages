//
//  TaskDetailView.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI


struct TaskDetailView: View {
    let task: Task
    @EnvironmentObject private var appState: AppState
    @State private var startTime: Date = Date()
    @State private var isRunning: Bool = false

    var body: some View {
        VStack {
            // Main content
            HStack(spacing: 20) {
                // Left side: Task Detail
                VStack(alignment: .leading, spacing: 20) {
                    Text(task.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text(task.description)
                        .foregroundColor(.white)
                    HStack {
                        Text("Difficulty: \(task.difficulty.rawValue)")
                        Text("Importance: \(task.importance.rawValue)")
                    }
                    .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                // Right side: Timer
                VStack(spacing: 20) {
                    Text("Task Timer")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    Text("Задача: \(task.title)")
                        .font(.title3)
                        .foregroundColor(.white)
                    Text("Описание: \(task.description)")
                        .foregroundColor(.white)
                    if isRunning {
                        Text("Время: \(Date().timeIntervalSince(startTime), specifier: "%.0f") секунд")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Button(action: {
                        if isRunning {
                            isRunning = false
                        } else {
                            startTime = Date()
                            isRunning = true
                        }
                    }) {
                        Text(isRunning ? "Остановить" : "Запустить")
                            .padding()
                            .background(isRunning ? Color.red : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .font(.headline)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .gradientBackground()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            )
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                CustomBackButton(action: { appState.pop() })
            }
        }
    }
}
