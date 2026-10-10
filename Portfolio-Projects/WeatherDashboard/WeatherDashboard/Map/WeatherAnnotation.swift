//
//  WeatherAnnotation.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI

struct WeatherAnnotation: View {

    let city: String
    let temperature: Int
    let condition: String

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {

            Text(city)
                .font(.headline)

            Text("\(temperature)°")
                .font(.subheadline)
                .foregroundStyle(.blue)

            Text(condition)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
