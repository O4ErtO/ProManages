//
//  TaskViewModel.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//
import Foundation
import Combine
import Supabase

class TaskViewModel: ObservableObject {
    @Published var tasks: [Taskis] = []
    @Published var projects: [Project] = []

    private var cancellables = Set<AnyCancellable>()
    private let supabaseClient = SupabaseClients.shared.client

    func fetchTasks(for project: Project) async {
        do {
            let response: PostgrestResponse<[Taskis]> = try await supabaseClient.database.from("tasks").select().eq("project_id", value: project.id.uuidString).execute()
            DispatchQueue.main.async {
                self.tasks = response.value
            }
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }

    func fetchProjects() async {
        do {
            let response: PostgrestResponse<[Project]> = try await supabaseClient.database.from("projects").select().execute()
            DispatchQueue.main.async {
                self.projects = response.value
            }
        } catch {
            print("Error fetching projects: \(error)")
        }
    }

    func addTask(_ task: Taskis) async {
        do {
            try await supabaseClient.database.from("tasks").insert(task.asDictionary).execute()
            DispatchQueue.main.async {
                self.tasks.append(task)
            }
        } catch {
            print("Error adding task: \(error)")
        }
    }

    func addProject(_ project: Project) async {
        do {
            try await supabaseClient.database.from("projects").insert(project.asDictionary).execute()
            DispatchQueue.main.async {
                self.projects.append(project)
            }
        } catch {
            print("Error adding project: \(error)")
        }
    }

    func updateTask(_ task: Taskis) async {
        do {
            try await supabaseClient.database.from("tasks")
                .update(task.asDictionary)
                .eq("id", value: task.id)
                .execute()
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                DispatchQueue.main.async {
                    self.tasks[index] = task
                }
            }
        } catch {
            print("Error updating task: \(error)")
        }
    }

    func deleteTask(_ task: Taskis) async {
        do {
            try await supabaseClient.database.from("tasks").delete().eq("id", value: task.id).execute()
            DispatchQueue.main.async {
                self.tasks.removeAll { $0.id == task.id }
            }
        } catch {
            print("Error deleting task: \(error)")
        }
    }
}

extension Taskis {
    var asDictionary: Encodable {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return [
            "id": id.uuidString,
            "title": title,
            "description": description,
            "project_id": projectId.uuidString,
            "assigned_user_id": assignedUserId.uuidString,
            "type": type.rawValue,
            "difficulty": difficulty.rawValue,
            "importance": importance.rawValue,
            "start_time": formatter.string(from: Date()),
            "end_time": formatter.string(from: Date().addingTimeInterval(3600)),
            "state": state.rawValue
        ]
    }
}
