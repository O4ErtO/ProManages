//
//  TaskDetailView.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//

import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    @EnvironmentObject private var appState: AppState

    init(task: Taskis) {
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
    }

    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.task.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                HStack {
                    Text("Difficulty: \(viewModel.task.difficulty.rawValue)")
                    Text("Importance: \(viewModel.task.importance.rawValue)")
                }
                .foregroundColor(.gray)
                Text(viewModel.task.description)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            ProjectInfoView(viewModel: viewModel)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                CustomBackButton(action: { appState.pop() })
            }
        }
    }
}
