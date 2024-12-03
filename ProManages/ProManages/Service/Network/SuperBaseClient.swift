//
//  SupaBaseManager.swift
//  ProManages
//
//  Created by Artem Vekshin on 03.12.2024.
//
import Supabase
import Foundation

class SupabaseClients {
    static let shared = SupabaseClients()
    let client: SupabaseClient

    private init() {
        let url: String? = "https://cdiypkfgmxnydvvcifof.supabase.co"
        let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkaXlwa2ZnbXhueWR2dmNpZm9mIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMzIyMTY4NCwiZXhwIjoyMDQ4Nzk3Njg0fQ.Ve7k_XCOsEDD7yIeqoJxn2jjfv2ukGE7OtSohYK8pIQ"
        
        guard let url = URL(string: url ?? ""), !key.isEmpty else {
            fatalError("Supabase URL or API Key is missing.")
        }
        client = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
}
