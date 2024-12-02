//
//  ProjectInfoView.swift
//  ProManages
//
//  Created by Artem Vekshin on 30.11.2024.
//


import SwiftUI

struct ProjectInfoView: View {
    @ObservedObject var viewModel: TaskDetailViewModel
    
    let states = [TaskState.open, TaskState.inProgress, TaskState.completed, TaskState.onHold]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Проект")
                    .font(.title2)
                    .foregroundColor(.primary)
                Spacer()
                Image("project_icon")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            Text(viewModel.task.project?.title ?? "Нет проекта")
                .font(.largeTitle)
                .bold()
            
            Divider()
            
            sectionRow(title: "Приоритет", content: viewModel.task.importance.rawValue, colorIndicator: viewModel.task.importance == .low ? Color.green : Color.red)
        
            sectionRow(title: "Тип", content: viewModel.task.type.rawValue)
            
            sectionRow(title: "Сложность", content: viewModel.task.difficulty.rawValue)
            
            statePickerRow()
            
            HStack {
                Text("Исполнитель")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                HStack(spacing: 12) {
                    Image("default_image")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Text(viewModel.task.assignedUser?.username ?? "Нет исполнителя")
                        .font(.headline)
                }
            }
            
            sectionRow(title: "Оценка времени", content: viewModel.task.difficulty.rawValue)
            
            sectionRow(title: "Затраченное время", content: formatTimeInterval(viewModel.elapsedTime))
            
            Spacer()
            
        }
        .padding(16)
        .background(.clear)
    }
    
    private func sectionRow(title: String, content: String, colorIndicator: Color? = nil) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
            if let color = colorIndicator {
                HStack {
                    Text(content)
                        .font(.headline)
                    Circle()
                        .fill(color)
                        .frame(width: 14, height: 14)
                }
            } else {
                Text(content)
                    .font(.headline)
            }
        }
    }
    
    
    private func statePickerRow() -> some View {
        HStack {
            Text("Состояние")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()

            Menu {
                ForEach(states, id: \.self) { state in
                    Button(action: {
                        viewModel.updateState(state)
                    }) {
                        Text(state.rawValue)
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.task.state.rawValue)
                        .font(.headline)
                }
            }
            .foregroundColor(.primary)
        }
    }
    
    
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "00:00:00"
    }
}
