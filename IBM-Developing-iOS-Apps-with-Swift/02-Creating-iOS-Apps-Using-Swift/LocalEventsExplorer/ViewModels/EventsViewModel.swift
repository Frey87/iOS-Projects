//
//  EventsViewModel.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import Foundation
import Observation

@MainActor
@Observable
class EventsViewModel {

    var citySearchText = ""
    var events: [Event] = []
    var isLoading = false
    var errorMessage: String?

    private let eventsService = EventsService()

    var filteredEvents: [Event] {

        let trimmedSearch = citySearchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if trimmedSearch.isEmpty {
            return events
        }

        return events.filter {
            $0.city.localizedCaseInsensitiveContains(
                trimmedSearch
            )
        }
    }

    func loadEvents() async {

        isLoading = true
        errorMessage = nil

        do {
            let fetchedEvents =
                try await eventsService.fetchEvents()

            self.events = fetchedEvents

        } catch {

            errorMessage =
                "Unable to load events. Please try again."
        }

        isLoading = false
    }
}
