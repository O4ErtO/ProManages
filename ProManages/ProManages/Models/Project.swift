//
//  Project.swift
// 
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

struct Project: Identifiable, Codable, Hashable, Equatable {
    var id: UUID
    var title: String
    var description: String
    var tasks: [Taskis]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case tasks
    }

    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
}

