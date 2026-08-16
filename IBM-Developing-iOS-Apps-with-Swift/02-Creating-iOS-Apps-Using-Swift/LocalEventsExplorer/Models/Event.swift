//
//  Event.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import Foundation

struct Event: Codable, Identifiable {
    let id: String
    let name: String
    let category: String
    let city: String

    let venueName: String
    let latitude: Double
    let longitude: Double
    let eventDate: String
    let priceMin: Double
    let priceMax: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case city
        case venueName = "venue_name"
        case latitude
        case longitude
        case eventDate = "event_date"
        case priceMin = "price_min"
        case priceMax = "price_max"
    }
}
