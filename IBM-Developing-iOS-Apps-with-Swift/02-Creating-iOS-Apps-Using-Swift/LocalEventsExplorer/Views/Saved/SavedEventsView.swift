//
//  SavedEventsView.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import SwiftData

struct SavedEventsView: View {

    @Environment(\.modelContext)
    private var context

    @Query(sort: \SavedEvent.dateSaved)
    private var savedEvents: [SavedEvent]

    @State private var searchText = ""

    var filteredEvents: [SavedEvent] {
        guard !searchText.isEmpty else {
            return savedEvents
        }

        return savedEvents.filter {
            $0.eventName.localizedCaseInsensitiveContains(
                searchText
            )
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredEvents) { event in
                    NavigationLink {
                        SavedEventDetailView(
                            event: event
                        )
                    } label: {
                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {
                            Text(event.eventName)
                                .font(.headline)

                            Text(event.city)
                                .foregroundStyle(.secondary)

                            Text(event.eventDate)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(
                    perform: deleteEvents
                )
            }
            .navigationTitle("Saved Events")
            .searchable(
                text: $searchText,
                prompt: "Search saved events"
            )
        }
    }

    private func deleteEvents(
        at offsets: IndexSet
    ) {
        for index in offsets {
            context.delete(
                filteredEvents[index]
            )
        }

        try? context.save()
    }
}

#Preview {
    SavedEventsView()
        .modelContainer(
            for: SavedEvent.self,
            inMemory: true
        )
}
