import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var savedEvents: [SavedEvent]

    @State private var viewModel = EventsViewModel()
    @State private var animateCards = false
    @State private var savedEventIDs: Set<String> = []

    private let columns = [
        GridItem(.adaptive(minimum: 160))
    ]

    var body: some View {
        TabView {

            NavigationStack {
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: 20
                    ) {
                        TextField(
                            "Enter city (e.g., Dallas)",
                            text: $viewModel.citySearchText
                        )
                        .textFieldStyle(.roundedBorder)

                        Button("Find Events") {
                            loadEvents()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isLoading)

                        if viewModel.isLoading {
                            ProgressView()
                                .transition(.opacity)
                        }

                        if let errorMessage = viewModel.errorMessage {
                            VStack {
                                Text(errorMessage)
                                    .multilineTextAlignment(.center)

                                Button("Retry") {
                                    loadEvents()
                                }
                            }
                            .transition(
                                .move(edge: .bottom)
                                    .combined(with: .opacity)
                            )
                        }

                        LazyVGrid(
                            columns: columns,
                            spacing: 16
                        ) {
                            ForEach(
                                Array(
                                    viewModel.filteredEvents
                                        .enumerated()
                                ),
                                id: \.element.id
                            ) { index, event in

                                EventCard(
                                    event: event,
                                    isSaved: savedEventIDs.contains(event.id),
                                    onSaveTapped: {
                                        toggleSave(for: event)
                                    }
                                )
                                .opacity(
                                    animateCards ? 1 : 0
                                )
                                .offset(
                                    y: animateCards ? 0 : 60
                                )
                                .animation(
                                    .easeInOut(duration: 0.7)
                                        .delay(
                                            Double(index) * 0.08
                                        ),
                                    value: animateCards
                                )
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Events")
            }
            .tabItem {
                Label(
                    "Events",
                    systemImage: "calendar"
                )
            }

            EventsMapView(
                events: viewModel.filteredEvents
            )
            .tabItem {
                Label(
                    "Map",
                    systemImage: "map"
                )
            }

            SavedEventsView()
                .tabItem {
                    Label(
                        "Saved",
                        systemImage: "heart"
                    )
                }
        }
        .task {
            savedEventIDs = Set(
                savedEvents.map(\.eventID)
            )

            print(
                "Container configurations:",
                context.container.configurations
            )
        }
        .onChange(of: savedEvents.map(\.eventID)) { _, newIDs in
            savedEventIDs = Set(newIDs)
        }
    }

    private func loadEvents() {
        Task {
            animateCards = false

            await viewModel.loadEvents()

            withAnimation(.spring()) {
                animateCards = true
            }
        }
    }

    @MainActor
    private func toggleSave(for event: Event) {

        print("toggleSave called:", event.id)

        do {
            if let existingEvent = savedEvents.first(
                where: {
                    $0.eventID == event.id
                }
            ) {
                context.delete(existingEvent)

                withAnimation {
                    _ = savedEventIDs.remove(event.id)
                }

                print("Deleted:", event.id)

            } else {
                let savedEvent = SavedEvent(
                    eventID: event.id,
                    eventName: event.name,
                    venue: event.venueName,
                    city: event.city,
                    latitude: event.latitude,
                    longitude: event.longitude,
                    eventDate: event.eventDate,
                    priceMin: event.priceMin,
                    priceMax: event.priceMax
                )

                context.insert(savedEvent)

                withAnimation {
                    _ = savedEventIDs.insert(event.id)
                }

                print("Inserted:", event.id)
            }

            try context.save()

            print("SAVE SUCCESS")

        } catch {
            print("SAVE FAILED:", error)
            print("DESCRIPTION:", error.localizedDescription)

            savedEventIDs = Set(
                savedEvents.map(\.eventID)
            )
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: SavedEvent.self,
            inMemory: true
        )
}

