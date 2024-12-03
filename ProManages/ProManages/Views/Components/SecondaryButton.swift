//
//  SecondaryButton.swift
//
//  Created by Artem Vekshin on 18.11.2024.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.blue)
                .padding(.top, 10)
        }
    }
}
