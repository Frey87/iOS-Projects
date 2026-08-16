//
//  LocalEventsExplorerApp.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import SwiftData

@main
struct LocalEventsExplorerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            for: SavedEvent.self
        )
    }
}
