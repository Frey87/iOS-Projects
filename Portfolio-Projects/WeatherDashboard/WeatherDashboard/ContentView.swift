//
//  ContentView.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(WeatherViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context

    @Query private var savedLocations: [SavedLocation]

    @State private var animateCards = false

    private let gridColumns = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]

    private let hourlyRows = [
        GridItem(.fixed(130))
    ]

    private var isCurrentCitySaved: Bool {
        savedLocations.contains {
            $0.name.caseInsensitiveCompare(viewModel.city) == .orderedSame
        }
    }

    var body: some View {
        TabView {
            weatherDashboardContent
                .tabItem {
                    Label(
                        "Weather",
                        systemImage: "cloud.sun.fill"
                    )
                }

            MapTab()
                .tabItem {
                    Label(
                        "Map",
                        systemImage: "map.fill"
                    )
                }

            FavouritesTab()
                .tabItem {
                    Label(
                        "Favourites",
                        systemImage: "heart.fill"
                    )
                }
        }
    }

    private var weatherDashboardContent: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.35),
                    Color.cyan.opacity(0.2),
                    Color.white
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: 28
                ) {
                    titleSection
                    searchSection

                    if viewModel.isLoading {
                        ProgressView("Loading Weather...")
                            .frame(maxWidth: .infinity)
                            .transition(
                                .move(edge: .top)
                                .combined(with: .opacity)
                            )
                    }

                    if let errorMessage = viewModel.errorMessage {
                        errorSection(message: errorMessage)
                    }

                    headerSection
                    forecastSection
                    hourlySection
                    footerSection
                }
                .padding()
                .animation(
                    .easeInOut(duration: 0.4),
                    value: viewModel.isLoading
                )
                .animation(
                    .easeInOut(duration: 0.4),
                    value: viewModel.errorMessage
                )
            }
        }
        .task {
            await loadInitialWeather()
        }
    }
}

// MARK: - Main sections

private extension ContentView {
    var titleSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Weather Dashboard")
                        .font(
                            .system(
                                size: 38,
                                weight: .black
                            )
                        )

                    Text("Weekly weather overview")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    toggleCurrentCitySaved()
                } label: {
                    HStack {
                        Image(
                            systemName: isCurrentCitySaved
                                ? "heart.fill"
                                : "heart"
                        )

                        Text(
                            isCurrentCitySaved
                                ? "Saved"
                                : "Save"
                        )
                    }
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        isCurrentCitySaved
                            ? Color.red
                            : Color.blue
                    )
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .disabled(viewModel.isLoading)
            }
        }
        .padding(.top, 8)
    }

    var searchSection: some View {
        @Bindable var bindableViewModel = viewModel

        return VStack(
            alignment: .leading,
            spacing: 10
        ) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField(
                    "Search city...",
                    text: $bindableViewModel.citySearchText
                )
                .font(.subheadline)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
                .submitLabel(.search)
                .onSubmit {
                    Task {
                        await searchWeather()
                    }
                }

                if !bindableViewModel.citySearchText.isEmpty {
                    Button {
                        bindableViewModel.citySearchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear city search")
                }
            }
            .padding(12)
            .background(.ultraThinMaterial)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
            .shadow(
                color: .black.opacity(0.06),
                radius: 4,
                x: 0,
                y: 2
            )

            Text("Press Return to search any city")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    var headerSection: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.9),
                        Color.cyan.opacity(0.7)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                HStack {
                    VStack(
                        alignment: .leading,
                        spacing: 14
                    ) {
                        Text(viewModel.city)
                            .font(
                                .system(
                                    size: max(
                                        geometry.size.width * 0.08,
                                        26
                                    ),
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)

                        HStack(
                            alignment: .bottom,
                            spacing: 10
                        ) {
                            Text(
                                "\(viewModel.currentTemperature)°"
                            )
                            .font(
                                .system(
                                    size: max(
                                        geometry.size.width * 0.16,
                                        54
                                    ),
                                    weight: .heavy
                                )
                            )
                            .foregroundStyle(.white)
                            .contentTransition(.numericText())

                            Text(viewModel.currentCondition)
                                .font(.title3)
                                .foregroundStyle(
                                    .white.opacity(0.9)
                                )
                                .padding(.bottom, 10)
                        }

                        Text(
                            "H: \(viewModel.high)°   L: \(viewModel.low)°"
                        )
                        .foregroundStyle(
                            .white.opacity(0.85)
                        )
                    }

                    Spacer(minLength: 16)

                    Image(
                        systemName: currentWeatherIcon
                    )
                    .font(.system(size: 70))
                    .foregroundStyle(currentWeatherColor)
                    .shadow(
                        color: currentWeatherColor.opacity(0.45),
                        radius: 10
                    )
                    .rotationEffect(
                        .degrees(
                            viewModel.isRefreshing
                                ? 720
                                : 0
                        )
                    )
                    .animation(
                        .linear(duration: 1.2),
                        value: viewModel.isRefreshing
                    )
                }
                .padding(28)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 32)
            )
            .shadow(
                color: .blue.opacity(0.2),
                radius: 12,
                x: 0,
                y: 6
            )
        }
        .frame(height: 220)
    }

    var forecastSection: some View {
        VStack(
            alignment: .leading,
            spacing: 18
        ) {
            HStack {
                Text("5-Day Forecast")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: "calendar")
                    .foregroundStyle(.secondary)
            }

            LazyVGrid(
                columns: gridColumns,
                spacing: 16
            ) {
                ForEach(
                    Array(
                        viewModel.filteredForecasts.enumerated()
                    ),
                    id: \.element.id
                ) { index, item in
                    WeatherCard {
                        HStack(alignment: .top) {
                            VStack(
                                alignment: .leading,
                                spacing: 12
                            ) {
                                Text(item.day)
                                    .font(.headline)
                                    .foregroundStyle(.secondary)

                                Text("\(item.temperature)°")
                                    .font(
                                        .system(
                                            size: 42,
                                            weight: .bold
                                        )
                                    )
                                    .contentTransition(
                                        .numericText()
                                    )

                                Text(item.condition)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            ZStack {
                                Circle()
                                    .fill(
                                        forecastColor(
                                            for: item.condition
                                        )
                                        .opacity(0.15)
                                    )
                                    .frame(
                                        width: 52,
                                        height: 52
                                    )

                                Image(systemName: item.icon)
                                    .font(.title2)
                                    .foregroundStyle(
                                        forecastColor(
                                            for: item.condition
                                        )
                                    )
                            }
                        }
                        .frame(height: 120)
                    }
                    .opacity(animateCards ? 1 : 0)
                    .offset(
                        y: animateCards
                            ? 0
                            : 80
                    )
                    .animation(
                        .spring(
                            duration: 1.2,
                            bounce: 0.25
                        )
                        .delay(Double(index) * 0.18),
                        value: animateCards
                    )
                }
            }
        }
    }

    var hourlySection: some View {
        VStack(
            alignment: .leading,
            spacing: 18
        ) {
            HStack {
                Text("Hourly Forecast")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: "clock")
                    .foregroundStyle(.secondary)
            }

            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                LazyHGrid(
                    rows: hourlyRows,
                    spacing: 14
                ) {
                    ForEach(viewModel.hourlyData) { item in
                        WeatherCard {
                            VStack(spacing: 14) {
                                Text(item.hour)
                                    .font(.headline)
                                    .foregroundStyle(.secondary)

                                ZStack {
                                    Circle()
                                        .fill(
                                            Color.orange.opacity(0.15)
                                        )
                                        .frame(
                                            width: 48,
                                            height: 48
                                        )

                                    Image(systemName: item.icon)
                                        .font(.title3)
                                        .foregroundStyle(.orange)
                                }

                                Text("\(item.temperature)°")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .contentTransition(
                                        .numericText()
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 110)
                        }
                        .frame(width: 92)
                    }
                }
            }
        }
    }

    var footerSection: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            Text("Today's Highlights")
                .font(.headline)

            HStack {
                Label(
                    "Humidity 68%",
                    systemImage: "drop.fill"
                )

                Spacer()

                Label(
                    "Wind 12 km/h",
                    systemImage: "wind"
                )
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .cardStyle()
    }

    func errorSection(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .transition(
                    .move(edge: .bottom)
                    .combined(with: .opacity)
                )

            Button("Retry") {
                Task {
                    await searchWeather()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Data actions

private extension ContentView {
    func loadInitialWeather() async {
        animateCards = false

        await viewModel.loadWeather(
            for: viewModel.citySearchText
        )

        guard !Task.isCancelled else {
            return
        }

        try? await Task.sleep(
            for: .milliseconds(150)
        )

        guard !Task.isCancelled else {
            return
        }

        withAnimation {
            animateCards = true
        }
    }

    func searchWeather() async {
        let city = viewModel.citySearchText
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !city.isEmpty else {
            return
        }

        animateCards = false

        withAnimation(
            .spring(
                duration: 1.5,
                bounce: 0.35
            )
        ) {
            viewModel.isRefreshing = true
        }

        await viewModel.loadWeather(for: city)

        guard !Task.isCancelled else {
            viewModel.isRefreshing = false
            return
        }

        try? await Task.sleep(
            for: .milliseconds(500)
        )

        withAnimation(
            .easeInOut(duration: 1.0)
        ) {
            viewModel.isRefreshing = false
        }

        try? await Task.sleep(
            for: .milliseconds(150)
        )

        guard !Task.isCancelled else {
            return
        }

        withAnimation {
            animateCards = true
        }
    }

    func toggleCurrentCitySaved() {
        guard viewModel.currentTemperature != 0 else {
            return
        }

        if let existingLocation = savedLocations.first(
            where: {
                $0.name.caseInsensitiveCompare(
                    viewModel.city
                ) == .orderedSame
            }
        ) {
            context.delete(existingLocation)

            do {
                try context.save()
            } catch {
                print(
                    "Failed to remove saved location: \(error)"
                )
            }

            return
        }

        let location = SavedLocation(
            name: viewModel.city,
            latitude: viewModel.currentLatitude,
            longitude: viewModel.currentLongitude
        )

        let baseTemperature = Double(
            viewModel.currentTemperature
        )

        for dayOffset in 0..<7 {
            let historyDate = Calendar.current.date(
                byAdding: .day,
                value: -(6 - dayOffset),
                to: .now
            ) ?? .now

            let history = WeatherHistory(
                temperature: baseTemperature
                    + Double.random(in: -5...5),
                condition: viewModel.currentCondition,
                date: historyDate
            )

            history.location = location
            location.weatherHistory.append(history)
        }

        context.insert(location)

        do {
            try context.save()
        } catch {
            print(
                "Failed to save location: \(error)"
            )
        }
    }
}

// MARK: - Weather presentation

private extension ContentView {
    var currentWeatherIcon: String {
        switch viewModel.currentCondition.lowercased() {
        case "rain", "drizzle":
            return "cloud.rain.fill"

        case "clouds", "cloudy":
            return "cloud.fill"

        case "snow":
            return "snowflake"

        case "thunderstorm":
            return "cloud.bolt.fill"

        case "mist", "fog", "haze":
            return "cloud.fog.fill"

        default:
            return "sun.max.fill"
        }
    }

    var currentWeatherColor: Color {
        switch viewModel.currentCondition.lowercased() {
        case "rain", "drizzle":
            return .blue

        case "clouds", "cloudy":
            return .gray

        case "snow":
            return .cyan

        case "thunderstorm":
            return .purple

        case "mist", "fog", "haze":
            return .gray

        default:
            return .yellow
        }
    }

    func forecastColor(
        for condition: String
    ) -> Color {
        switch condition.lowercased() {
        case "rain", "drizzle":
            return .blue

        case "clouds", "cloudy":
            return .gray

        case "snow":
            return .cyan

        case "thunderstorm":
            return .purple

        default:
            return .orange
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .environment(WeatherViewModel())
        .modelContainer(
            for: [
                SavedLocation.self,
                WeatherHistory.self
            ],
            inMemory: true
        )
}
