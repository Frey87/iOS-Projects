//
//  SavedEventRow.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI

struct SavedEventRow: View {

    let event: SavedEvent

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            Text(event.eventName)
                .font(.headline)

            Label(
                event.city,
                systemImage: "mappin.and.ellipse"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Label(
                formattedDate,
                systemImage: "calendar"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }

    private var formattedDate: String {

        guard let date = ISO8601DateFormatter().date(
            from: event.eventDate
        ) else {
            return event.eventDate
        }

        return date.formatted(
            date: .abbreviated,
            time: .shortened
        )
    }
}
