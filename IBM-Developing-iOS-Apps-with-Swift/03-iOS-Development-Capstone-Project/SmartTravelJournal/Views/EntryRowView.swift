//
//  EntryRowView.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import SwiftUI

struct EntryRowView: View {
    let entry: JournalEntry
    
    @Environment(\.modelContext) private var modelContext
    @State private var tagViewModel = SmartTagViewModel()
    
    @ScaledMetric private var circleSize: CGFloat = 40

    var body: some View {
        HStack(spacing: 12) {

            ZStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.15))
                    .frame(width: circleSize, height: circleSize)

                Text(entry.mood.emoji)
                    .font(.title3)
            }

            VStack(alignment: .leading, spacing: 4) {

                HStack {
                    Text(entry.title)
                        .font(.headline)

                    Spacer()

                    Text(entry.timestamp, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(
                    entry.timestamp,
                    format: .dateTime.hour().minute()
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Text(entry.body)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                if tagViewModel.isGenerating {
                    ProgressView()
                        .controlSize(.mini)

                } else if !tagViewModel.tags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(tagViewModel.tags, id: \.self) { tag in
                                TagChipView(tag: tag)
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .task {
            await tagViewModel.generate(
                for: entry,
                context: modelContext
            )
        }
    }
}
