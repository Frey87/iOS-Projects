//
//  SmartTags.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation
import FoundationModels

@Generable
struct SmartTags {

    @Guide(
        description: "A list of up to 4 short content tags describing the journal entry. Examples: beach, food, hiking, culture."
    )
    var tags: [String]
}
