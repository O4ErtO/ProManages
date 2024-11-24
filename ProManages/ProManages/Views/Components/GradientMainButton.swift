// GradientButton.swift
//
// Created by Artem Vekshin on 24.11.2024.
//

import SwiftUI

struct GradientButton: View {
    let action: () -> Void
    let title: String

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .cornerRadius(12)
                )
                .foregroundColor(.white)
                .font(.headline)
        }
        .buttonStyle(.plain)
    }
}
