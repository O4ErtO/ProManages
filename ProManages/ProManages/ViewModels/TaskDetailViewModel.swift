//
//  TaskDetailViewModel.swift
//  ProManages
//
//  Created by Artem Vekshin on 30.11.2024.
//

import SwiftUI
import Combine
import Supabase

class TaskDetailViewModel: ObservableObject {
    @Published var task: Taskis
    @Published var isRunning: Bool = false
    @Published var startTime: Date?

    private var timer: AnyCancellable?

    var elapsedTime: TimeInterval {
        if let startTime = startTime {
            return Date().timeIntervalSince(startTime)
        }
        return 0
    }

    init(task: Taskis) {
        self.task = task
    }

    func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        startTime = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
    }

    func stopTimer() {
        isRunning = false
        timer?.cancel()
        timer = nil
    }

    func stateColor(for state: TaskState) -> Color {
        switch state {
        case .open: return .blue
        case .inProgress: return .orange
        case .completed: return .green
        case .onHold: return .yellow
        }
    }

    private func updateTimer() {
        // Если потребуется дополнительная логика обновления
    }

    func updateState(_ newState: TaskState) {
        task.state = newState
        if newState == .inProgress {
            startTimer()
        } else {
            stopTimer()
        }
    }

    func updateTaskTime() async {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // Фетчинг затраченного времени
        let startTime = formatter.date(from: task.startTime) ?? Date()
        let endTime = formatter.date(from: task.endTime) ?? Date()
        let elapsedTime = endTime.timeIntervalSince(startTime)

        // Обновление даты окончания
        let updatedEndTime = Date().addingTimeInterval(elapsedTime)

        let updatedTask = Taskis(
            id: task.id,
            title: task.title,
            description: task.description,
            projectId: task.projectId,
            assignedUserId: task.assignedUserId,
            type: task.type,
            difficulty: task.difficulty,
            importance: task.importance,
            startTime: formatter.string(from: startTime),
            endTime: formatter.string(from: updatedEndTime),
            state: task.state
        )

        do {
            try await SupabaseClients.shared.client.database.from("tasks")
                .update(updatedTask.asDictionary)
                .eq("id", value: updatedTask.id)
                .execute()
            DispatchQueue.main.async {
                self.task = updatedTask
            }
        } catch {
            print("Error updating task time: \(error)")
        }
    }
}
