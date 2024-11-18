//
//  Project.swift
// 
//
//  Created by Artem Vekshin on 11.11.2024.
//

import Foundation

struct Project: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var tasks: [Task]
}
