//
//  JournalEntryEditor.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import SwiftUI
import SwiftData
import CoreLocation

struct JournalEntryEditor: View {

    @Environment(JournalEntryViewModel.self) private var entryViewModel
    @Environment(LocationManager.self) private var locationManager
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var weatherText: String = ""
    @State private var isLoadingWeather: Bool = false
    @State private var weatherError: String? = nil

    private let locationService = LocationService()

    let trip: Trip

    private let imageNames = [
        "trip_beach",
        "trip_mountain",
        "trip_city",
        "trip_forest",
        "trip_desert"
    ]

    private let imageLabels = [
        "Beach",
        "Mountain",
        "City",
        "Forest",
        "Desert"
    ]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        @Bindable var vm = entryViewModel

        NavigationStack {
            Form {

                Section("Entry Details") {
                    TextField(
                        "Entry title",
                        text: $vm.title
                    )

                    TextField(
                        "Write about your trip...",
                        text: $vm.body,
                        axis: .vertical
                    )
                    .lineLimit(4...8)

                    DatePicker(
                        "Date & Time",
                        selection: $vm.timestamp,
                        displayedComponents: [
                            .date,
                            .hourAndMinute
                        ]
                    )
                }

                Section("Location") {
                    if let coordinate = locationManager.currentCoordinate {
                        LabeledContent(
                            "Latitude",
                            value: String(format: "%.4f", coordinate.latitude)
                        )

                        LabeledContent(
                            "Longitude",
                            value: String(format: "%.4f", coordinate.longitude)
                        )
                    } else {
                        Text("Detecting location...")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("Weather at Location") {
                    if isLoadingWeather {
                        ProgressView("Fetching weather...")
                            .transition(
                                .move(edge: .top)
                                    .combined(with: .opacity)
                            )

                    } else if let weatherError {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(weatherError)
                                .foregroundStyle(.red)

                            Button("Retry") {
                                Task {
                                    await fetchWeather()
                                }
                            }
                        }
                        .transition(
                            .move(edge: .top)
                                .combined(with: .opacity)
                        )

                    } else if !weatherText.isEmpty {
                        Text(weatherText)
                            .font(.subheadline)
                            .transition(
                                .move(edge: .top)
                                    .combined(with: .opacity)
                            )

                    } else {
                        Text("Weather will appear when your location is available.")
                            .foregroundStyle(.secondary)
                            .transition(
                                .move(edge: .top)
                                    .combined(with: .opacity)
                            )
                    }
                }
                .animation(
                    .easeInOut(duration: 0.3),
                    value: isLoadingWeather
                )

                Section("Mood") {
                    HStack {
                        ForEach(Mood.allCases) { mood in
                            Button {
                                vm.mood = mood
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji)
                                        .font(.title2)

                                    Text(mood.label)
                                        .font(.caption2)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    vm.mood == mood
                                        ? Color.accentColor.opacity(0.2)
                                        : Color.clear
                                )
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 8
                                    )
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                Section("Travel Image") {
                    LazyVGrid(
                        columns: columns,
                        spacing: 12
                    ) {
                        ForEach(
                            Array(imageNames.enumerated()),
                            id: \.offset
                        ) { index, name in

                            VStack(spacing: 4) {
                                Image(name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 70)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 8
                                        )
                                    )
                                    .overlay {
                                        RoundedRectangle(
                                            cornerRadius: 8
                                        )
                                        .stroke(
                                            vm.imageName == name
                                                ? Color.accentColor
                                                : Color.clear,
                                            lineWidth: 3
                                        )
                                    }

                                Text(imageLabels[index])
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .onTapGesture {
                                vm.imageName = name
                            }
                        }
                    }
                }

                Section(
                    footer: Text(
                        "Entry will be timestamped automatically"
                    )
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(
                    placement: .topBarTrailing
                ) {
                    Button("Save") {
                        entryViewModel.saveEntry(
                            to: trip,
                            context: modelContext
                        )

                        dismiss()
                    }
                    .disabled(
                        !entryViewModel.isFormValid
                    )
                }
            }
            
            .onAppear {
                locationManager.requestPermission()
                locationManager.startUpdating()

                if let coordinate = locationManager.currentCoordinate {
                    vm.latitude = coordinate.latitude
                    vm.longitude = coordinate.longitude

                    Task {
                        await fetchWeather()
                    }
                }
            }
            .onChange(
                of: locationManager.currentCoordinate?.latitude
            ) { _, newValue in

                guard newValue != nil else { return }

                if let coordinate = locationManager.currentCoordinate {
                    vm.latitude = coordinate.latitude
                    vm.longitude = coordinate.longitude
                }

                Task {
                    await fetchWeather()
                }
            }
        }
    }
    private func fetchWeather() async {
        guard let coordinate = locationManager.currentCoordinate else {
            return
        }

        isLoadingWeather = true
        weatherError = nil

        do {
            let response = try await locationService.fetchWeather(
                for: coordinate
            )

            let condition =
                response.weather.first?.description
                ?? "Unknown conditions"

            weatherText = String(
                format: "%@ • %.1f°C • %@",
                response.name,
                response.main.temp,
                condition.capitalized
            )
        } catch let error as APIError {
            weatherError = error.errorDescription
        } catch {
            weatherError =
                APIError.networkUnavailable.errorDescription
        }

        isLoadingWeather = false
    }
}
