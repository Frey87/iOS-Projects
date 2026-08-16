//
//  Mood+Charts.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation

extension Mood {
    var numericValue: Int {
        switch self {
        case .tired:
            return 1
        case .sad:
            return 2
        case .calm:
            return 3
        case .happy:
            return 4
        case .excited:
            return 5
        }
    }
}
