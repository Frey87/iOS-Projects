//
//  FavouritesTab.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import SwiftData

struct FavouritesTab: View {
    @Query(
        sort: \SavedLocation.dateAdded,
        order: .reverse
    )
    private var locations: [SavedLocation]

    @Environment(\.modelContext) private var modelContext

    @Namespace private var animation

    var body: some View {
        NavigationStack {
            Group {
                if locations.isEmpty {
                    emptyState
                } else {
                    locationsList
                }
            }
            .navigationTitle("Favourites")
        }
    }

    private var emptyState: some View {
        ContentUnavailableView(
            "No Saved Locations",
            systemImage: "heart.slash",
            description: Text(
                "Save a city from the Weather tab to see it here."
            )
        )
    }

    private var locationsList: some View {
        List {
            ForEach(locations) { location in
                NavigationLink {
                    LocationDetailView(
                        location: location,
                        animation: animation
                    )
                } label: {
                    locationRow(for: location)
                }
            }
            .onDelete(perform: deleteLocations)
        }
        .listStyle(.insetGrouped)
    }

    private func locationRow(
        for location: SavedLocation
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: "location.fill")
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 42, height: 42)
                .background(
                    Color.blue.opacity(0.12)
                )
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(location.name)
                    .font(.headline)
                    .matchedGeometryEffect(
                        id: location.id,
                        in: animation
                    )

                Text(
                    coordinateDescription(for: location)
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Text(
                    "Saved \(location.dateAdded, style: .relative)"
                )
                .font(.caption2)
                .foregroundStyle(.tertiary)
            }

            Spacer()

            if let latestWeather = latestWeather(
                for: location
            ) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(
                        "\(Int(latestWeather.temperature))°F"
                    )
                    .font(.headline)

                    Text(latestWeather.condition)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }

    private func latestWeather(
        for location: SavedLocation
    ) -> WeatherHistory? {
        location.weatherHistory.max {
            $0.date < $1.date
        }
    }

    private func coordinateDescription(
        for location: SavedLocation
    ) -> String {
        let latitudeDirection =
            location.latitude >= 0 ? "N" : "S"

        let longitudeDirection =
            location.longitude >= 0 ? "E" : "W"

        let latitude = String(
            format: "%.4f°%@",
            abs(location.latitude),
            latitudeDirection
        )

        let longitude = String(
            format: "%.4f°%@",
            abs(location.longitude),
            longitudeDirection
        )

        return "\(latitude), \(longitude)"
    }

    private func deleteLocations(
        at offsets: IndexSet
    ) {
        for index in offsets {
            modelContext.delete(locations[index])
        }

        do {
            try modelContext.save()
        } catch {
            print(
                "Could not delete saved location: \(error)"
            )
        }
    }
}

#Preview {
    FavouritesTab()
        .modelContainer(
            for: [
                SavedLocation.self,
                WeatherHistory.self
            ],
            inMemory: true
        )
}

