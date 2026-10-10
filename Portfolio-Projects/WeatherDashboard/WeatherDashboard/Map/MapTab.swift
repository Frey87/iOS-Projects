//
//  MapTab.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import MapKit
import CoreLocation

enum MapDisplayStyle: String, CaseIterable, Identifiable {

    case standard
    case imagery
    case hybrid

    var id: String { rawValue }
}

struct MapTab: View {

    @State private var position: MapCameraPosition =
        .automatic

    @State private var mapStyle: MapDisplayStyle =
        .standard

    @State private var selectedLocation: String = ""

    @State private var locationManager =
        LocationManager()

    @State private var locations: [MapLocation] = [

        MapLocation(
            city: "San Francisco",
            temperature: 72,
            condition: "Sunny",
            latitude: 37.7749,
            longitude: -122.4194
        ),

        MapLocation(
            city: "Tokyo",
            temperature: 68,
            condition: "Cloudy",
            latitude: 35.6762,
            longitude: 139.6503
        ),

        MapLocation(
            city: "London",
            temperature: 58,
            condition: "Rain",
            latitude: 51.5072,
            longitude: -0.1276
        )
    ]

    var body: some View {

        VStack(spacing: 0) {

            Picker(
                "Map Style",
                selection: $mapStyle
            ) {

                Text("Standard")
                    .tag(MapDisplayStyle.standard)

                Text("Imagery")
                    .tag(MapDisplayStyle.imagery)

                Text("Hybrid")
                    .tag(MapDisplayStyle.hybrid)
            }
            .pickerStyle(.segmented)
            .padding()

            MapReader { proxy in

                Map(position: $position) {

                    ForEach(locations) { location in

                        Marker(
                            location.city,
                            systemImage: "cloud.sun.fill",
                            coordinate: location.coordinate
                        )
                        .tint(.red)

                        Annotation(
                            location.city,
                            coordinate: location.coordinate
                        ) {

                            WeatherAnnotation(
                                city: location.city,
                                temperature: location.temperature,
                                condition: location.condition
                            )
                        }
                    }
                }
                .mapStyle(
                    mapStyle == .standard
                    ? .standard
                    : mapStyle == .imagery
                    ? .imagery
                    : .hybrid
                )
                .overlay(alignment: .bottomTrailing) {

                    Button {

                        locationManager.requestPermission()

                        locationManager.requestLocation()

                        withAnimation {

                            position = .userLocation(
                                fallback: .automatic
                            )
                        }

                    } label: {

                        Image(
                            systemName:
                                "location.circle.fill"
                        )
                        .font(.system(size: 36))
                        .foregroundStyle(.blue)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(Circle())
                    }
                    .padding()
                }
                .simultaneousGesture(

                    SpatialTapGesture()
                        .onEnded { value in

                            guard let coordinate =
                                proxy.convert(
                                    value.location,
                                    from: .local
                                ) else {
                                    return
                                }

                            Task {

                                guard let request =
                                    MKReverseGeocodingRequest(
                                        location: CLLocation(
                                            latitude: coordinate.latitude,
                                            longitude: coordinate.longitude
                                        )
                                    ) else {
                                        return
                                    }

                                do {

                                    let mapItems =
                                        try await request.mapItems

                                    selectedLocation =
                                        mapItems.first?.name
                                        ?? "Unknown"

                                    print(selectedLocation)

                                } catch {

                                    print(error.localizedDescription)
                                }
                            }
                        }
                )
            }
        }
    }
}

#Preview {
    MapTab()
}

