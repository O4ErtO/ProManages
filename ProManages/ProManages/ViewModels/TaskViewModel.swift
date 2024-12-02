//
//  TaskViewModel.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import SwiftUI
import FirebaseFirestore

class TaskViewModel: ObservableObject {
    @Published var tasks: [Taskis] = []
    @Published var projects: [Project] = []

    private var db = Firestore.firestore()

    func fetchTasks() {
        db.collection("tasks").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching tasks: \(error.localizedDescription)")
                return
            }
            self.tasks = snapshot?.documents.compactMap { document in
                try? document.data(as: Taskis.self)
            } ?? []
        }
    }

    func addTask(_ task: Taskis) {
        do {
            _ = try db.collection("tasks").addDocument(from: task)
        } catch let error {
            print("Error adding task: \(error.localizedDescription)")
        }
    }

    func updateTask(_ task: Taskis) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID.uuidString).setData(from: task)
            } catch let error {
                print("Error updating task: \(error.localizedDescription)")
            }
        }
    }

    func deleteTask(_ task: Taskis) {
        if let taskID = task.id {
            db.collection("tasks").document(taskID.uuidString).delete { error in
                if let error = error {
                    print("Error deleting task: \(error.localizedDescription)")
                }
            }
        }
    }
}
