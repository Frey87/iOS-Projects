//
//  APIError.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import Foundation

enum APIError: Error {

    case networkUnavailable
    case invalidResponse
    case decodingFailed
    case serverError(Int)
}
