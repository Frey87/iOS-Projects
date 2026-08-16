//
//  MapPlaceholderView.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import SwiftUI
import MapKit
import SwiftData

struct MapTabView: View {

    @Query
    private var entries: [JournalEntry]

    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var selectedMapStyle: MapStyleOption = .standard

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                Picker("Map Style", selection: $selectedMapStyle) {
                    ForEach(MapStyleOption.allCases) { option in
                        Text(option.label)
                            .tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                ZStack(alignment: .bottom) {
                    Map(position: $cameraPosition) {
                        ForEach(entries) { entry in
                            if entry.id == entries.first?.id {
                                Annotation(
                                    entry.title,
                                    coordinate: entry.coordinate
                                ) {
                                    EntryAnnotationView(entry: entry)
                                }
                            } else {
                                Marker(
                                    entry.title,
                                    systemImage: entry.mood.mapIcon,
                                    coordinate: entry.coordinate
                                )
                                .tint(entry.mood.mapColor)
                            }
                        }
                    }
                    .mapStyle(selectedMapStyle.style)

                    MapSummaryCard(
                        entryCount: entries.count
                    )
                }
            }
            .navigationTitle("Map")
        }
    }
}
