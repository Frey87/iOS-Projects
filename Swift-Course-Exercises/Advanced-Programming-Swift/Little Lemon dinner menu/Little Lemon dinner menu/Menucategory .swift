//
//  Menucategory .swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import Foundation

// Task 3.1 & 3.3: MenuCategory enum, adopts the String protocol (RawRepresentable via String)
// CaseIterable + Identifiable added so we can loop over cases in SwiftUI (used in MenuItemsOptionView)
enum MenuCategory: String, CaseIterable, Identifiable, Equatable {
    case food = "Food"
    case drink = "Drink"
    case dessert = "Dessert"

    var id: String { rawValue }
}
