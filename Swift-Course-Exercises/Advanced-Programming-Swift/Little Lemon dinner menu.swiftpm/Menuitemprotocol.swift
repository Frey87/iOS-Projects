//
//  Menuitemprotocol.swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import Foundation

// Task 7: Protocol that enforces the required conformances on menu item delegates.
//
// Note: the assignment text lists "Price" twice (once as "Double, get" and once as
// "Int, get and set"), which looks like a typo — a menu item only needs one price.
// I implemented `price` as the get-only Double (since prices need decimals, e.g. $9.99)
// and treated the get/set requirements as applying to `ordersCount` and `ingredients`,
// which matches the rest of the task list. Flag this with your instructor if it should
// be interpreted differently.
protocol MenuItemProtocol {
    var id: UUID { get }
    var price: Double { get }
    var title: String { get }
    var menuCategory: MenuCategory { get }
    var ordersCount: Int { get set }
    var ingredients: [Ingredient] { get set }
}
