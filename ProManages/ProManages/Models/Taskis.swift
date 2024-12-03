// Task.swift
//
// Created by Artem Vekshin on 11.11.2024.
//

import Foundation
import SwiftUI

struct Taskis: Identifiable, Codable, Hashable, Equatable {
    var id: UUID
    var title: String
    var description: String
    var projectId: UUID // Используем projectId вместо Project
    var assignedUserId: UUID // Используем assignedUserId вместо User
    var type: TaskType
    var difficulty: TaskDifficulty
    var importance: TaskImportance
    var startTime: String
    var endTime: String
    var state: TaskState

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

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case projectId = "project_id"
        case assignedUserId = "assigned_user_id"
        case type
        case difficulty
        case importance
        case startTime = "start_time"
        case endTime = "end_time"
        case state
    }

    // Реализация Equatable
    static func == (lhs: Taskis, rhs: Taskis) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.description == rhs.description
    }

    // Реализация Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
}

enum TaskType: String, Codable {
    case urgent = "Срочная"
    case nonUrgent = "Не срочная"
}

enum TaskImportance: String, Codable {
    case low = "Низкая"
    case medium = "Средняя"
    case high = "Высокая"
}

enum TaskDifficulty: String, Codable {
    case easy = "Легкая"
    case medium = "Средняя"
    case hard = "Трудная"
}

enum TaskState: String, Codable {
    case open = "Открыта"
    case inProgress = "В процессе"
    case completed = "Завершена"
    case onHold = "Отложена"
}
