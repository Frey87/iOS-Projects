import SwiftUI

struct EventMapAnnotation: View {

    let event: Event

    @State private var isExpanded = false

    var body: some View {
        Button {
            withAnimation(.snappy) {
                isExpanded.toggle()
            }
        } label: {
            VStack(spacing: 6) {
                if isExpanded {
                    eventInformation
                        .transition(
                            .scale.combined(with: .opacity)
                        )
                }

                Image(systemName: categoryIcon)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 38, height: 38)
                    .background(categoryColor)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
                    .shadow(radius: 4)

                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .foregroundStyle(categoryColor)
                    .rotationEffect(.degrees(180))
                    .offset(y: -9)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(annotationAccessibilityLabel)
    }

    private var eventInformation: some View {
        VStack(
            alignment: .leading,
            spacing: 5
        ) {
            Text(event.name)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(2)

            Text(event.category)
                .font(.caption2)
                .foregroundStyle(.secondary)

            Text(formattedPriceRange)
                .font(.caption2)
                .fontWeight(.semibold)
        }
        .frame(width: 170, alignment: .leading)
        .padding(10)
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(radius: 4)
    }

    private var formattedPriceRange: String {
        if event.priceMin == 0,
           event.priceMax == 0 {
            return "Free"
        }

        if event.priceMin == 0 {
            let maximum = event.priceMax.formatted(
                .currency(code: "USD")
            )

            return "Free – \(maximum)"
        }

        if event.priceMin == event.priceMax {
            return event.priceMin.formatted(
                .currency(code: "USD")
            )
        }

        let minimum = event.priceMin.formatted(
            .currency(code: "USD")
        )

        let maximum = event.priceMax.formatted(
            .currency(code: "USD")
        )

        return "\(minimum) – \(maximum)"
    }

    private var categoryIcon: String {
        switch event.category.lowercased() {
        case "concert":
            return "music.note"
        case "sports":
            return "sportscourt.fill"
        case "theater":
            return "theatermasks.fill"
        case "comedy":
            return "face.smiling.fill"
        case "festival":
            return "party.popper.fill"
        default:
            return "calendar"
        }
    }

    private var categoryColor: Color {
        switch event.category.lowercased() {
        case "concert":
            return .purple
        case "sports":
            return .blue
        case "theater":
            return .indigo
        case "comedy":
            return .orange
        case "festival":
            return .green
        default:
            return .red
        }
    }

    private var annotationAccessibilityLabel: String {
        """
        \(event.name), \
        \(event.category), \
        \(event.city), \
        \(formattedPriceRange)
        """
    }
}

#Preview {
    NavigationStack {
        EventsMapView(
            events: [
                Event(
                    id: "evt_001",
                    name: "Coldplay – Music of the Spheres Tour",
                    category: "Concert",
                    city: "Dallas",
                    venueName: "American Airlines Center",
                    latitude: 32.7905,
                    longitude: -96.8103,
                    eventDate: "2026-06-14T20:00:00Z",
                    priceMin: 89,
                    priceMax: 245
                ),
                Event(
                    id: "evt_002",
                    name: "Dallas Mavericks vs Boston Celtics",
                    category: "Sports",
                    city: "Dallas",
                    venueName: "American Airlines Center",
                    latitude: 32.7905,
                    longitude: -96.8103,
                    eventDate: "2026-06-16T19:30:00Z",
                    priceMin: 45,
                    priceMax: 180
                )
            ]
        )
    }
}
