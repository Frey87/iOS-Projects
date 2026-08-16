//
//  EventTip.swift
//  LocalEventsExplorer
//
//  Created by Valentyn Verovkin on 12.07.2026.
//


import Foundation
import FoundationModels

@Generable
struct EventTip {

    @Guide(description: "Keep responses short")
    let outfitSuggestion: String

    @Guide(description: "Suggest one useful item")
    let itemToBring: String

    @Guide(description: "Provide a short arrival recommendation")
    let arrivalTip: String
}

