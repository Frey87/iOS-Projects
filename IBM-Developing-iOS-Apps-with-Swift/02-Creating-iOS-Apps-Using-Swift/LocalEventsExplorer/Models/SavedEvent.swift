import Foundation
import SwiftData

@Model
final class SavedEvent {

    var eventID: String

    var eventName: String
    var venue: String
    var city: String

    var latitude: Double
    var longitude: Double

    var eventDate: String

    var priceMin: Double
    var priceMax: Double

    var dateSaved: Date

    init(
        eventID: String,
        eventName: String,
        venue: String,
        city: String,
        latitude: Double,
        longitude: Double,
        eventDate: String,
        priceMin: Double,
        priceMax: Double,
        dateSaved: Date = .now
    ) {
        self.eventID = eventID
        self.eventName = eventName
        self.venue = venue
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.eventDate = eventDate
        self.priceMin = priceMin
        self.priceMax = priceMax
        self.dateSaved = dateSaved
    }
}
