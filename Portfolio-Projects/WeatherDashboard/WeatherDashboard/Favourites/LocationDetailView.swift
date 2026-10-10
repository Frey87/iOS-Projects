//
//  LocationDetailView.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import SwiftData

struct LocationDetailView: View {
    let location: SavedLocation
    let animation: Namespace.ID

    @State private var tipViewModel = LocationDetailViewModel()

    private var sortedHistory: [WeatherHistory] {
        location.weatherHistory.sorted { $0.date < $1.date }
    }

    private var latestWeather: WeatherHistory? {
        location.weatherHistory.max { $0.date < $1.date }
    }

    private var latestTemperature: Int {
        Int(latestWeather?.temperature ?? 72)
    }

    private var latestCondition: String {
        latestWeather?.condition ?? "Clear"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: - Header card

                VStack(alignment: .leading, spacing: 8) {
                    Text(location.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(
                            id: location.id,
                            in: animation
                        )

                    Text("Saved \(location.dateAdded, style: .relative)")
                        .foregroundStyle(.secondary)

                    HStack(spacing: 16) {
                        Label(
                            String(
                                format: "%.4f°N",
                                location.latitude
                            ),
                            systemImage: "location.north.fill"
                        )

                        Label(
                            String(
                                format: "%.4f°E",
                                location.longitude
                            ),
                            systemImage: "location.fill"
                        )
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .padding()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .background(.regularMaterial)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )

                // MARK: - AI Travel Tips

                TravelTipView(
                    viewModel: tipViewModel,
                    city: location.name,
                    temperature: latestTemperature,
                    condition: latestCondition
                )

                // MARK: - Temperature chart

                VStack(alignment: .leading, spacing: 8) {
                    Text("Temperature History")
                        .font(.title2)
                        .fontWeight(.bold)

                    TemperatureChartView(
                        history: sortedHistory
                    )
                }

                // MARK: - Records list

                if !sortedHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Records")
                            .font(.title2)
                            .fontWeight(.bold)

                        ForEach(sortedHistory) { entry in
                            HStack {
                                Text(entry.date, style: .date)
                                    .foregroundStyle(.secondary)

                                Spacer()

                                Text("\(Int(entry.temperature))°F")
                                    .fontWeight(.medium)

                                Text(entry.condition)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)

                            Divider()
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                }
            }
            .padding()
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await tipViewModel.generateTip(
                city: location.name,
                temperature: latestTemperature,
                condition: latestCondition
            )
        }
    }
}
