//
//  StatCard.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import SwiftUI

struct StatCard<Content: View>: View {
    let title: String
    let color: Color

    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)

            content()
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            color.opacity(0.85)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}
