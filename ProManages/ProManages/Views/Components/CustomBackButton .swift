//
//  CustomBackButton .swift
//  ProManages
//
//  Created by Artem Vekshin on 24.11.2024.
//

import SwiftUI

struct CustomBackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.backward")
                .foregroundColor(.blue)
                .padding(5)
                .background(Color.purple.opacity(0.8))
                .clipShape(Circle())
        }
    }
}
