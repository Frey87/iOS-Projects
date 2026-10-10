//
//  WeatherResponse.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import Foundation

struct WeatherResponse: Codable {

    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let coord: Coord
    let sys: Sys
}
