//
//  Sortoption .swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import Foundation

// Task 2: "Sort menu items" section is built from this enum.
// Not explicitly requested by name in Task 3, but the task instructions say
// both sections in MenuItemsOptionView should be created using enums.
enum SortOption: String, CaseIterable, Identifiable {
    case mostPopular = "Most Popular"
    case price = "Price $-$$$"
    case aToZ = "A-Z"

    var id: String { rawValue }
}
