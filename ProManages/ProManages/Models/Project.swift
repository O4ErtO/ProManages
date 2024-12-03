//
//  Project.swift
// 
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

struct Project: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var description: String

    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
}
