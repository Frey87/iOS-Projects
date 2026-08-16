//
//  APIError.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation

enum APIError: Error, LocalizedError {
    case networkUnavailable
    case invalidResponse
    case decodingFailed
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return "No internet connection."

        case .invalidResponse:
            return "The server returned an invalid response."

        case .decodingFailed:
            return "The weather response could not be decoded."

        case .serverError(let statusCode):
            return "The server returned an error with status code \(statusCode)."
        }
    }
}
