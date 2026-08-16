import SwiftUI
import Charts

struct SavedEventDetailView: View {

    let event: SavedEvent

    @State private var selectedDay: String?
    @State private var isGeneratingTips = false

    @State private var outfitSuggestion =
        "Wear comfortable clothing appropriate for the event."

    @State private var itemToBring =
        "Bring your ticket and a fully charged phone."

    @State private var arrivalTip =
        "Plan to arrive 20 to 30 minutes before the event starts."

    private var chartData: [PricePoint] {
        let difference = event.priceMax - event.priceMin

        return [
            PricePoint(
                day: "4 weeks",
                price: event.priceMin
            ),
            PricePoint(
                day: "3 weeks",
                price: event.priceMin + difference * 0.25
            ),
            PricePoint(
                day: "2 weeks",
                price: event.priceMin + difference * 0.50
            ),
            PricePoint(
                day: "1 week",
                price: event.priceMin + difference * 0.75
            ),
            PricePoint(
                day: "Event",
                price: event.priceMax
            )
        ]
    }

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 24
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text(event.eventName)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(event.venue)
                        .font(.headline)

                    Text(event.city)
                        .foregroundStyle(.secondary)

                    Text(event.eventDate)
                        .foregroundStyle(.secondary)

                    Text(
                        "\(event.priceMin.formatted(.currency(code: "USD"))) – \(event.priceMax.formatted(.currency(code: "USD")))"
                    )
                    .fontWeight(.semibold)
                }

                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {
                    Text("Ticket Price Trend")
                        .font(.title2)
                        .fontWeight(.bold)

                    Chart(chartData) { item in
                        AreaMark(
                            x: .value("Day", item.day),
                            y: .value("Price", item.price)
                        )

                        LineMark(
                            x: .value("Day", item.day),
                            y: .value("Price", item.price)
                        )
                    }
                    .frame(height: 250)
                    .chartXSelection(
                        value: $selectedDay
                    )
                }

                VStack(
                    alignment: .leading,
                    spacing: 16
                ) {
                    HStack {
                        Text("AI Event Tips")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        Button("Generate Tips") {
                            generateTips()
                        }
                        .disabled(isGeneratingTips)
                    }

                    if isGeneratingTips {
                        ProgressView()
                            .frame(
                                maxWidth: .infinity,
                                alignment: .center
                            )
                    } else {
                        VStack(
                            alignment: .leading,
                            spacing: 12
                        ) {
                            recommendationRow(
                                title: "Outfit Suggestion",
                                text: outfitSuggestion,
                                systemImage: "tshirt"
                            )

                            recommendationRow(
                                title: "Item to Bring",
                                text: itemToBring,
                                systemImage: "bag"
                            )

                            recommendationRow(
                                title: "Arrival Tip",
                                text: arrivalTip,
                                systemImage: "clock"
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func recommendationRow(
        title: String,
        text: String,
        systemImage: String
    ) -> some View {
        HStack(
            alignment: .top,
            spacing: 12
        ) {
            Image(systemName: systemImage)
                .foregroundStyle(.tint)
                .frame(width: 28)

            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                Text(title)
                    .font(.headline)

                Text(text)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func generateTips() {
        isGeneratingTips = true

        Task { @MainActor in
            try? await Task.sleep(
                for: .seconds(2)
            )

            outfitSuggestion =
                "Choose comfortable clothing suitable for the weather and event category."

            itemToBring =
                "Bring your ticket, identification, and a charged phone."

            arrivalTip =
                "Arrive about 30 minutes early to allow time for entry."

            isGeneratingTips = false
        }
    }
}

private struct PricePoint: Identifiable {
    let id = UUID()
    let day: String
    let price: Double
}
