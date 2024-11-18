//
//  ProjectListView.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI

struct ProjectListView: View {
    @StateObject var projectViewModel = ProjectViewModel()

    var body: some View {
        NavigationView {
            List(projectViewModel.projects) { project in
                NavigationLink(destination: TaskListView()) {
                    Text(project.title)
                }
            }
            .navigationTitle("Projects")
        }
    }
}

#Preview {
    ProjectListView()
}
