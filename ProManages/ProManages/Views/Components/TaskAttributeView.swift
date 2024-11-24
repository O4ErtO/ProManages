//
//  TaskAttributeView.swift
//  ProManages
//
//  Created by Artem Vekshin on 24.11.2024.
//

import SwiftUI

struct TaskAttributeView: View {
    let title: String
    let value: String
    let color: Color?

    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(color ?? .primary)
        }
    }
}
