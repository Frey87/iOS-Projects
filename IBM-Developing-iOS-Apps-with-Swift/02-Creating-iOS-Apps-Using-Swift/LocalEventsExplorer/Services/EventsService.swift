//
//  EventsService.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import Foundation

final class EventsService {

    private let eventsURL = URL(
        string: "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/F3Y3rrlatukAJ_mAJT4a8Q/events.json"
    )

    func fetchEvents() async throws -> [Event] {
        guard let url = eventsURL else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(
            from: url
        )

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()

        let eventsResponse = try decoder.decode(
            EventsResponse.self,
            from: data
        )

        return eventsResponse.events
    }
}


