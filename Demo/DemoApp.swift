//
//  DemoApp.swift
//  Demo
//
//  Created by Trey Gaines on 6/10/25.
//

import SwiftUI
import SwiftData

@main
struct DemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Search()
        }
        .modelContainer(sharedModelContainer)
    }
}
