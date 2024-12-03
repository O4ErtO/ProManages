//
//  ProjectViewModel.swift
//  
//
//  Created by Artem Vekshin on 11.11.2024.
//


import Foundation
import Combine
import Supabase

import Foundation
import Combine
import Supabase

class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []

    private var cancellables = Set<AnyCancellable>()
    private let supabaseClient = SupabaseClients.shared.client

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
}


extension Project {
    var asDictionary: Encodable {
        return [
            "id": id.uuidString,
            "title": title,
            "description": description
        ]
    }
}
