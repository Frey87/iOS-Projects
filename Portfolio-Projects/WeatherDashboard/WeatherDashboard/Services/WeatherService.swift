//
//  WeatherService.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import Foundation

class WeatherService {

    private let networkService = NetworkService()

    private let apiKey = "a7002dab94a802a2e15cf5ab955da39d"

    func fetchWeather(city: String) async throws(APIError) -> WeatherResponse {

        var components = URLComponents(
            string: "https://api.openweathermap.org/data/2.5/weather"
        )

        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "imperial")
        ]

        guard let url = components?.url else {
            throw APIError.invalidResponse
        }

        let response: WeatherResponse =
            try await networkService.fetch(url: url)

        return response
    }
}
