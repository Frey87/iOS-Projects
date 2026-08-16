//
//  TripSummaryViewModel.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation
import SwiftData
import FoundationModels

@Observable
final class TripSummaryViewModel {

    var summary: TripSummary? = nil
    var isGenerating: Bool = false
    var errorMessage: String? = nil
    var wasGeneratedByAI: Bool = false

    private let service = TripSummaryService()

    func generate(
        for trip: Trip,
        context: ModelContext
    ) async {

        // 1. Use cached summary if it already exists
        if let cachedSummary = trip.aiSummary {
            let highlights = trip.aiHighlightsCSV?
                .components(separatedBy: ",")
                .map {
                    $0.trimmingCharacters(in: .whitespaces)
                } ?? []

            summary = TripSummary(
                summary: cachedSummary,
                highlights: highlights
            )

            return
        }

        // 2. Graceful fallback when Foundation Models is unavailable
        if case .unavailable =
            SystemLanguageModel.default.availability {

            summary = TripSummary(
                summary: "AI features require Apple Intelligence.",
                highlights: []
            )

            return
        }

        // 3. Nothing to summarize yet
        if trip.entries.isEmpty {
            summary = TripSummary(
                summary: "Add journal entries to generate an AI trip summary.",
                highlights: []
            )

            return
        }

        // 4. Generate summary
        isGenerating = true
        errorMessage = nil

        do {
            let generated =
                try await service.generateSummary(for: trip)

            summary = generated
            wasGeneratedByAI = true

            // Cache result in SwiftData
            trip.aiSummary = generated.summary
            trip.aiHighlightsCSV =
                generated.highlights.joined(separator: ", ")

            try context.save()

        } catch {
            errorMessage =
                "Unable to generate summary. Please try again."
        }

        isGenerating = false
    }

    func retry(
        for trip: Trip,
        context: ModelContext
    ) async {

        summary = nil
        errorMessage = nil
        wasGeneratedByAI = false

        trip.aiSummary = nil
        trip.aiHighlightsCSV = nil

        do {
            try context.save()
        } catch {
            errorMessage =
                "Unable to reset the cached summary."
            return
        }

        await generate(
            for: trip,
            context: context
        )
    }
}
