//
//  SmartTagViewModel.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation
import SwiftData
import FoundationModels

@Observable
final class SmartTagViewModel {

    var tags: [String] = []
    var isGenerating: Bool = false
    var errorMessage: String? = nil

    private let service = SmartTagService()

    func generate(
        for entry: JournalEntry,
        context: ModelContext
    ) async {

        // 1. Load cached tags if available
        if let cached = entry.smartTagsCSV {
            tags = cached
                .components(separatedBy: ",")
                .map {
                    $0.trimmingCharacters(in: .whitespaces)
                }

            return
        }

        // 2. Fallback when Apple Intelligence is unavailable
        if case .unavailable =
            SystemLanguageModel.default.availability {

            tags = ["travel", "journal"]
            return
        }

        // 3. Generate tags
        isGenerating = true
        errorMessage = nil

        do {
            let generated =
                try await service.generateTags(for: entry)

            tags = generated.tags

            entry.smartTagsCSV =
                generated.tags.joined(separator: ", ")

            try context.save()

        } catch {
            tags = ["travel", "journal"]
            errorMessage =
                "Unable to generate smart tags."
        }

        isGenerating = false
    }
}
