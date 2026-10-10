//
//  WeatherDashboardApp.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import SwiftUI
import SwiftData

@main
struct WeatherDashboardApp: App {

    @State private var viewModel = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
        .modelContainer(for: [
            SavedLocation.self,
            WeatherHistory.self
        ])
    }
}




