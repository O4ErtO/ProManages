// ProjectListSideBarView.swift
//
// Created by Artem Vekshin on 11.11.2024.
//

import SwiftUI

struct ProjectListSideBarView: View {
    @ObservedObject var projectViewModel = ProjectViewModel()
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationView {
            List(projectViewModel.projects) { project in
                Text(project.title)
                    .onTapGesture {
                        appState.push(.showTask(project))
                    }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Projects")
            .onAppear {
                if appState.currentRoute == nil, let firstProject = projectViewModel.projects.first {
                    appState.push(.showTask(firstProject))
                }
            }

            if let currentRoute = appState.currentRoute {
                switch currentRoute {
                case .showTask(let project):
                    TaskListView(project: project)
                case .taskDetails(let task):
                    TaskDetailView(task: task)
                case .statistic:
                    Text("Statistic")
                }
            }
        }
        .gradientBackground()
    }
}
