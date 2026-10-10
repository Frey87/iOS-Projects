//
//  Little_Lemon_dinner_menuTests.swift
//  Little Lemon dinner menuTests
//
//  Created by Valentyn Verovkin on 25.07.2026.
//

import XCTest
@testable import Little_Lemon_dinner_menu

// Task 8: Unit tests for MenuItem, added to a test bundle target.
final class MenuItemTests: XCTestCase {

    // Task 8.3.1: title equals the initialized value
    func testMenuItemTitle() {
        let expectedTitle = "Test Burger"
        let item = MenuItem(
            title: expectedTitle,
            price: 9.99,
            menuCategory: .food,
            ingredients: [.pasta]
        )

        XCTAssertEqual(item.title, expectedTitle)
    }

    // Task 8.3.2: ingredients equal the initialized value
    func testMenuItemIngredients() {
        let expectedIngredients: [Ingredient] = [.spinach, .broccoli]
        let item = MenuItem(
            title: "Veggie Bowl",
            price: 7.50,
            menuCategory: .food,
            ingredients: expectedIngredients
        )

        XCTAssertEqual(item.ingredients, expectedIngredients)
    }
}
