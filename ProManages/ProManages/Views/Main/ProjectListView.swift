// ProjectListSideBarView.swift
//
// Created by Artem Vekshin on 11.11.2024.
//

import SwiftUI


struct ProjectListSideBarView: View {
    @StateObject var projectViewModel = ProjectViewModel()
    @EnvironmentObject private var appState: AppState
    @State private var selectedProject: Project?

    var body: some View {
        NavigationView {
            List(projectViewModel.projects) { project in
                HStack {
                    Text(project.title)
                        .onTapGesture {
                            appState.push(.showTask(project))
                            selectedProject = project
                        }
                    Spacer()
                    if selectedProject?.id == project.id {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Projects")
            .onAppear {
                Task {
                    await projectViewModel.fetchProjects()
                    if appState.currentRoute == nil, let firstProject = projectViewModel.projects.first {
                        appState.push(.showTask(firstProject))
                        selectedProject = firstProject
                    }
                }
            }

            if let currentRoute = appState.currentRoute {
                switch currentRoute {
                case .showTask(let project):
                    TaskListView()
                case .taskDetails(let task):
                    TaskDetailView(task: task, project: selectedProject?.title ?? "")
                case .statistic:
                    Text("Statistic")
                }
            }
        }
        .gradientBackground()
        .environmentObject(projectViewModel) // Передача ProjectViewModel в качестве environmentObject
    }
}
