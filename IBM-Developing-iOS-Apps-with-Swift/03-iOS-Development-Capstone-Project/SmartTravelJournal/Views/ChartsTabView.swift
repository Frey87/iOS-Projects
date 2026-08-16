//
//  ChartsPlaceholderView.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import SwiftUI
import SwiftData
import Charts

struct ChartsTabView: View {

    @Query private var trips: [Trip]
    @Query private var entries: [JournalEntry]

    private var sortedEntries: [JournalEntry] {
        entries.sorted { $0.timestamp < $1.timestamp }
    }

    private var topMood: Mood? {
        let moodCounts = Dictionary(grouping: entries, by: { $0.mood })
            .mapValues { $0.count }
        return moodCounts.max(by: { $0.value < $1.value })?.key
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if trips.isEmpty && entries.isEmpty {
                        ContentUnavailableView(
                            "No Data Yet",
                            systemImage: "chart.bar",
                            description: Text("Add trips and journal entries to see your statistics here.")
                        )
                        .padding(.top, 60)
                    } else {
                        if !entries.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Entries over Time")
                                    .font(.headline)
                                Text("LineMark · All entries")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Chart {
                                    ForEach(Array(sortedEntries.enumerated()), id: \.element.id) { index, entry in
                                        LineMark(
                                            x: .value("Date", entry.timestamp),
                                            y: .value("Entry", index + 1)
                                        )
                                        .foregroundStyle(.blue)
                                        .interpolationMethod(.catmullRom)

                                        AreaMark(
                                            x: .value("Date", entry.timestamp),
                                            y: .value("Entry", index + 1)
                                        )
                                        .foregroundStyle(.blue.opacity(0.15))
                                        .interpolationMethod(.catmullRom)
                                    }
                                }
                                .chartXAxis {
                                    AxisMarks(values: .automatic) { value in
                                        AxisValueLabel(format: .dateTime.month().day())
                                    }
                                }
                                .chartYAxis {
                                    AxisMarks(values: .automatic) { _ in
                                        AxisGridLine()
                                        AxisValueLabel()
                                    }
                                }
                                .frame(height: 200)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Mood Trends")
                                    .font(.headline)
                                Text("LineMark · All entries")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Chart {
                                    ForEach(sortedEntries) { entry in
                                        LineMark(
                                            x: .value("Date", entry.timestamp),
                                            y: .value("Mood", entry.mood.numericValue)
                                        )
                                        .foregroundStyle(.orange)
                                        .interpolationMethod(.catmullRom)

                                        AreaMark(
                                            x: .value("Date", entry.timestamp),
                                            y: .value("Mood", entry.mood.numericValue)
                                        )
                                        .foregroundStyle(.orange.opacity(0.15))
                                        .interpolationMethod(.catmullRom)
                                    }
                                }
                                .chartXAxis {
                                    AxisMarks(values: .automatic) { value in
                                        AxisValueLabel(format: .dateTime.month().day())
                                    }
                                }
                                .chartYAxis {
                                    AxisMarks(values: [1, 2, 3, 4, 5]) { value in
                                        AxisValueLabel {
                                            if let int = value.as(Int.self) {
                                                Text(moodEmoji(for: int))
                                                    .font(.caption2)
                                            }
                                        }
                                        AxisGridLine()
                                    }
                                }
                                .frame(height: 200)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                        }

                        HStack(spacing: 12) {
                            StatCard(title: "Total Entries", color: .blue) {
                                Text("\(entries.count)")
                            }
                            StatCard(title: "Total Trips", color: .green) {
                                Text("\(trips.count)")
                            }
                            StatCard(title: "Top Mood", color: .purple) {
                                Text(topMood?.emoji ?? "—")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationTitle("Charts")
        }
    }

    private func moodEmoji(for value: Int) -> String {
        switch value {
        case 1: return "😴"
        case 2: return "😔"
        case 3: return "🙂"
        case 4: return "😀"
        case 5: return "🤩"
        default: return ""
        }
    }
}
