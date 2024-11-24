// Task.swift
//
// Created by Artem Vekshin on 11.11.2024.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var project: Project?
    var assignedUser: User?
    var type: TaskType
    var difficulty: TaskDifficulty
    var importance: TaskImportance
    var startTime: Date?
    var endTime: Date?

    var urgencyColor: Color {
        switch importance {
        case .high: return .red
        case .medium: return .yellow
        case .low: return .green
        }
    }

    var difficultyColor: Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .yellow
        case .hard: return .red
        }
    }
}

enum TaskType: String {
    case urgent = "Срочная"
    case nonUrgent = "Не срочная"
}

enum TaskImportance: String {
    case low = "Низкая"
    case medium = "Средняя"
    case high = "Высокая"
}

enum TaskDifficulty: String {
    case easy = "Легкая"
    case medium = "Средняя"
    case hard = "Трудная"
}
