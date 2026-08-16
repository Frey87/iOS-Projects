//
//  EntryAnnotationView.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import SwiftUI

struct EntryAnnotationView: View {
    let entry: JournalEntry

    var body: some View {
        VStack(spacing: 2) {

            Text(entry.mood.emoji)
                .font(.title2)

            VStack(alignment: .leading, spacing: 2) {
                Text(entry.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(1)

                Text(entry.timestamp, style: .date)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(8)
            .background(.regularMaterial)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )

            Image(systemName: "triangle.fill")
                .font(.caption2)
                .rotationEffect(.degrees(180))
        }
    }
}
