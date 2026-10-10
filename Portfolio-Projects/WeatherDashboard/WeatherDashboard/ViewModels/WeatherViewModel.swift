//
//  WeatherViewModel.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//


import Foundation
import Observation

@MainActor
@Observable
final class WeatherViewModel {

    // MARK: - Current weather

    var city: String = "San Francisco"
    var currentTemperature: Int = 0
    var currentCondition: String = ""
    var high: Int = 0
    var low: Int = 0

    // MARK: - Search

    var searchText: String = ""
    var citySearchText: String = "San Francisco"

    // MARK: - Forecast data

    var forecastData: [Forecast] = []
    var hourlyData: [HourlyForecast] = []

    // MARK: - UI state

    var isLoading: Bool = false
    var isRefreshing: Bool = false
    var errorMessage: String?

    // MARK: - Stored response

    private var weather: WeatherResponse?

    // MARK: - Service

    private let weatherService: WeatherService

    // MARK: - Initialization

    init() {
        self.weatherService = WeatherService()
    }

    // MARK: - Coordinates

    var currentLatitude: Double {
        weather?.coord.lat ?? 0.0
    }

    var currentLongitude: Double {
        weather?.coord.lon ?? 0.0
    }

    // MARK: - Filtered forecast

    var filteredForecasts: [Forecast] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return forecastData
        }

        return forecastData.filter { forecast in
            forecast.condition.localizedCaseInsensitiveContains(query)
                || forecast.day.localizedCaseInsensitiveContains(query)
        }
    }

    // MARK: - Load weather

    func loadWeather(
        for city: String = "San Francisco"
    ) async {
        let normalizedCity = city.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !normalizedCity.isEmpty else {
            errorMessage = "Please enter a city name."
            return
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let response = try await weatherService.fetchWeather(
                city: normalizedCity
            )

            guard !Task.isCancelled else {
                return
            }

            applyWeatherResponse(response)
        } catch {
            errorMessage = message(for: error)
        }
    }
}

// MARK: - Weather response processing

private extension WeatherViewModel {

    func applyWeatherResponse(
        _ response: WeatherResponse
    ) {
        weather = response

        city = response.name
        citySearchText = response.name

        let temperature = Int(
            response.main.temp.rounded()
        )

        let condition =
            response.weather.first?.main ?? "Unknown"

        currentTemperature = temperature
        currentCondition = condition

        /*
         Якщо у вашій моделі MainWeather є tempMax і tempMin,
         замініть два наступні рядки на:

         high = Int(response.main.tempMax.rounded())
         low = Int(response.main.tempMin.rounded())
         */

        high = temperature + 4
        low = temperature - 4

        let currentIcon = weatherIcon(
            for: condition
        )

        forecastData = makeForecastData(
            baseTemperature: temperature,
            currentCondition: condition,
            currentIcon: currentIcon
        )

        hourlyData = makeHourlyData(
            baseTemperature: temperature,
            currentCondition: condition
        )
    }

    func makeForecastData(
        baseTemperature: Int,
        currentCondition: String,
        currentIcon: String
    ) -> [Forecast] {
        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.locale = Locale(
            identifier: "en_US"
        )
        formatter.dateFormat = "EEE"

        let temperatureOffsets = [
            2,
            -1,
            -3,
            1,
            3
        ]

        let conditions = [
            currentCondition,
            "Clouds",
            "Rain",
            currentCondition,
            "Clear"
        ]

        return temperatureOffsets.enumerated().map {
            index,
            offset in

            let date = calendar.date(
                byAdding: .day,
                value: index,
                to: .now
            ) ?? .now

            let condition = conditions[index]

            return Forecast(
                day: index == 0
                    ? "Today"
                    : formatter.string(from: date),
                icon: index == 0
                    ? currentIcon
                    : weatherIcon(for: condition),
                temperature: baseTemperature + offset,
                condition: displayCondition(
                    for: condition
                )
            )
        }
    }

    func makeHourlyData(
        baseTemperature: Int,
        currentCondition: String
    ) -> [HourlyForecast] {
        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.locale = Locale(
            identifier: "en_US"
        )
        formatter.dateFormat = "ha"

        let temperatureOffsets = [
            0,
            1,
            2,
            1,
            -1,
            -2
        ]

        let conditions = [
            currentCondition,
            currentCondition,
            currentCondition,
            "Clouds",
            "Clouds",
            "Clear"
        ]

        return temperatureOffsets.enumerated().map {
            index,
            offset in

            let date = calendar.date(
                byAdding: .hour,
                value: index,
                to: .now
            ) ?? .now

            let condition = conditions[index]

            return HourlyForecast(
                hour: index == 0
                    ? "Now"
                    : formatter.string(from: date),
                icon: index == 5
                    ? "sunset.fill"
                    : weatherIcon(for: condition),
                temperature: baseTemperature + offset
            )
        }
    }
}

// MARK: - Weather presentation

private extension WeatherViewModel {

    func weatherIcon(
        for condition: String
    ) -> String {
        switch condition.lowercased() {
        case "clear", "sunny":
            return "sun.max.fill"

        case "clouds", "cloudy":
            return "cloud.fill"

        case "rain", "drizzle":
            return "cloud.rain.fill"

        case "thunderstorm":
            return "cloud.bolt.rain.fill"

        case "snow":
            return "snowflake"

        case "mist", "fog", "haze", "smoke":
            return "cloud.fog.fill"

        default:
            return "cloud.sun.fill"
        }
    }

    func displayCondition(
        for condition: String
    ) -> String {
        switch condition.lowercased() {
        case "clear":
            return "Sunny"

        case "clouds":
            return "Cloudy"

        default:
            return condition
        }
    }
}

// MARK: - Error handling

private extension WeatherViewModel {

    func message(
        for error: APIError
    ) -> String {
        switch error {
        case .networkUnavailable:
            return "Network unavailable. Check your internet connection."

        case .invalidResponse:
            return "Invalid response from the weather server."

        case .decodingFailed:
            return "Failed to decode weather data."

        case .serverError(let code):
            return "Server error: \(code)"
        }
    }
}


