//
//  WeatherCard.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import SwiftUI

struct WeatherCard<Content: View>: View {    @ViewBuilder var content: Content;    @ScaledMetric(relativeTo: .body)
    private var cardSpacing: CGFloat = 12;    var body: some View {
        VStack(alignment: .leading, spacing: cardSpacing) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    WeatherCard {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "cloud.sun.fill")
                .font(.largeTitle)
            Text("72°")
                .font(.largeTitle)
            Text("Partly Cloudy")
                .font(.headline)
        }
    }
    .padding()
    .dynamicTypeSize(.accessibility5)
}


