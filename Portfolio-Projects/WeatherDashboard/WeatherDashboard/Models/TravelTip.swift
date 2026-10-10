//
//  TravelTip.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import FoundationModels

@Generable
struct TravelTip {

    @Guide(description: "A practical 2-3 sentence travel tip for the location based on the weather")
    var tip: String

    @Guide(description: "One specific packing item the traveller should bring, as a short phrase")
    var packingItem: String

    @Guide(description: "One local food dish to try, as a single dish name with a brief description")
    var localFood: String
}

extension TravelTip {

    static func fallback(for city: String) -> TravelTip {
        TravelTip(
            tip: "Check local weather forecasts before heading out in \(city). Layers are always a good idea when travelling.",
            packingItem: "Reusable water bottle",
            localFood: "Ask locals for their favourite neighbourhood restaurant"
        )
    }
}
