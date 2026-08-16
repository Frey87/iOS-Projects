//
//  LocationService.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation
import CoreLocation

final class LocationService {

    private let apiKey = "a7002dab94a802a2e15cf5ab955da39d"

    func fetchWeather(
        for coordinate: CLLocationCoordinate2D
    ) async throws -> WeatherResponse {

        let urlString =
            "https://api.openweathermap.org/data/2.5/weather" +
            "?lat=\(coordinate.latitude)" +
            "&lon=\(coordinate.longitude)" +
            "&appid=\(apiKey)" +
            "&units=metric"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidResponse
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw APIError.networkUnavailable
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(
                WeatherResponse.self,
                from: data
            )
        } catch {
            throw APIError.decodingFailed
        }
    }
}
