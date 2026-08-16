//
//  EventsMapView.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import MapKit

struct EventsMapView: View {

    let events: [Event]

    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 31.9686,
                longitude: -99.9018
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 8,
                longitudeDelta: 8
            )
        )
    )

    @State private var selectedMapStyle = "Standard"

    private var currentMapStyle: MapStyle {
        switch selectedMapStyle {
        case "Imagery":
            return .imagery

        case "Hybrid":
            return .hybrid

        default:
            return .standard
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker(
                    "Map Style",
                    selection: $selectedMapStyle
                ) {
                    Text("Standard")
                        .tag("Standard")

                    Text("Imagery")
                        .tag("Imagery")

                    Text("Hybrid")
                        .tag("Hybrid")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Map(position: $position) {
                    ForEach(events) { event in
                        Annotation(
                            event.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: event.latitude,
                                longitude: event.longitude
                            )
                        ) {
                            VStack(spacing: 4) {
                                Image(
                                    systemName: "mappin.circle.fill"
                                )
                                .font(.title)
                                .foregroundStyle(.red)

                                Text(event.name)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .lineLimit(2)

                                Text(event.category)
                                    .font(.caption2)

                                Text(
                                    "\(event.priceMin.formatted(.currency(code: "USD"))) – \(event.priceMax.formatted(.currency(code: "USD")))"
                                )
                                .font(.caption2)
                            }
                            .padding(8)
                            .background(.regularMaterial)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                        }
                    }
                }
                .mapStyle(currentMapStyle)

                Button {
                    withAnimation {
                        position = .userLocation(
                            fallback: .automatic
                        )
                    }
                } label: {
                    Label(
                        "My Location",
                        systemImage: "location.fill"
                    )
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Map")
        }
    }
}
