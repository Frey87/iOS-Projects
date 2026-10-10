//
//  NetworkService.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//
import Foundation

class NetworkService {

    func fetch<T: Decodable>(url: URL) async throws(APIError) -> T {

        let data: Data
        let response: URLResponse

        do {

            (data, response) =
                try await URLSession.shared.data(from: url)

        } catch {

            throw APIError.networkUnavailable
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {

            throw APIError.decodingFailed
        }
    }
}

