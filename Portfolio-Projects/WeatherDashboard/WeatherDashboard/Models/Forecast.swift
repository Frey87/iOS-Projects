//
//  Forecast.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import Foundation

struct Forecast: Identifiable {
    let id = UUID()
    let day: String
    let icon: String
    let temperature: Int
    let condition: String
}

