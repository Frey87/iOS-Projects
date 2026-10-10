//
//  TemperatureChartView.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import SwiftUI
import Charts
import SwiftData

struct TemperatureChartView: View {

    let history: [WeatherHistory]

    @State private var selectedDate: Date?

    var selectedEntry: WeatherHistory? {
        guard let selected = selectedDate else { return nil }
        return history.min(by: {
            abs($0.date.timeIntervalSince(selected)) <
            abs($1.date.timeIntervalSince(selected))
        })
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Chart {

                // Shaded gradient area
                ForEach(history) { entry in
                    AreaMark(
                        x: .value("Date", entry.date),
                        y: .value("Temperature", entry.temperature)
                    )
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.blue.opacity(0.3), .blue.opacity(0.0)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .interpolationMethod(.catmullRom)
                }

                // The line
                ForEach(history) { entry in
                    LineMark(
                        x: .value("Date", entry.date),
                        y: .value("Temperature", entry.temperature)
                    )
                    .foregroundStyle(.blue)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .interpolationMethod(.catmullRom)
                    .symbol(Circle().strokeBorder(lineWidth: 2))
                    .symbolSize(36)
                }

                // Vertical selection indicator
                if let entry = selectedEntry {
                    RuleMark(x: .value("Selected", entry.date))
                        .foregroundStyle(.orange)
                        .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4]))
                        .annotation(position: .top, alignment: .center) {
                            VStack(spacing: 2) {
                                Text("\(Int(entry.temperature))°F")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.orange)
                                Text(entry.date,
                                     format: .dateTime.weekday(.abbreviated))
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(6)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                }
            }
            .frame(height: 200)
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 7)) { _ in
                    AxisValueLabel(
                        format: .dateTime.weekday(.abbreviated)
                    )
                    AxisGridLine()
                }
            }
            .chartYAxis {
                AxisMarks { value in
                    AxisValueLabel {
                        if let temp = value.as(Double.self) {
                            Text("\(Int(temp))°")
                                .font(.caption)
                        }
                    }
                    AxisGridLine()
                }
            }
            .chartXSelection(value: $selectedDate)
            .padding(.vertical, 8)

            // Summary row below chart
            if let entry = selectedEntry {
                HStack {
                    Image(systemName: "thermometer")
                        .foregroundStyle(.orange)
                    Text("\(Int(entry.temperature))°F  —  \(entry.condition)")
                        .font(.subheadline)
                    Spacer()
                    Text(entry.date, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(10)
                .background(.orange.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Text("Tap the chart to see details")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
