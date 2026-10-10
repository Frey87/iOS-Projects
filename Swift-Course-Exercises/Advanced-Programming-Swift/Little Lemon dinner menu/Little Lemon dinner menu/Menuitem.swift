//
//  Menuitem.swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import Foundation

// Task 4: MenuItem with `title` and `ingredients`, conforming to Identifiable.
// Task 7: also conforms to MenuItemProtocol, adding id, price, menuCategory, ordersCount.
//
// Note: Task 7 refers to "the menu item class" — I kept this as a struct. In Swift,
// structs conform to protocols exactly the same way classes do, and a struct is the
// more idiomatic choice for a simple data/value type like this (no shared mutable
// reference semantics needed). Say the word if you specifically need a `class` instead
// and I'll switch it — the only change needed is `struct` -> `class` plus an explicit
// initializer.
struct MenuItem: Identifiable, MenuItemProtocol, Equatable {
    let id = UUID()
    let title: String
    let price: Double
    let menuCategory: MenuCategory
    var ordersCount: Int = 0
    var ingredients: [Ingredient]
}
