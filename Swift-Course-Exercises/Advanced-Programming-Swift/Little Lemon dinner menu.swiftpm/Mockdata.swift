//
//  Mockdata.swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import Foundation

// Task 5: Mock data — 12 food, 8 drink, 4 dessert MenuItems.
// Built functionally with `map`, per the functional-programming lesson tip.
enum MockData {

    static let foodItems: [MenuItem] = [
        ("Spinach Pasta", 12.99, [.spinach, .pasta]),
        ("Broccoli Stir Fry", 10.49, [.broccoli, .carrot]),
        ("Carrot Soup", 6.99, [.carrot]),
        ("Tomato Pasta", 11.49, [.pasta, .tomatoSauce]),
        ("Garden Salad", 8.99, [.spinach, .carrot, .broccoli]),
        ("Veggie Lasagna", 13.99, [.pasta, .tomatoSauce, .spinach]),
        ("Broccoli & Carrot Bowl", 9.49, [.broccoli, .carrot]),
        ("Spinach Ravioli", 12.49, [.spinach, .pasta, .tomatoSauce]),
        ("Roasted Carrot Plate", 7.99, [.carrot]),
        ("Pasta Marinara", 10.99, [.pasta, .tomatoSauce]),
        ("Spinach & Broccoli Wrap", 9.99, [.spinach, .broccoli]),
        ("Chef's Veggie Special", 14.99, [.spinach, .broccoli, .carrot, .pasta, .tomatoSauce])
    ].map { title, price, ingredients in
        MenuItem(title: title, price: price, menuCategory: .food,
                 ordersCount: Int.random(in: 0...500), ingredients: ingredients)
    }

    static let drinkItems: [MenuItem] = [
        ("Iced Tea", 3.49),
        ("Fresh Lemonade", 3.99),
        ("Sparkling Water", 2.49),
        ("Orange Juice", 4.49),
        ("Cold Brew Coffee", 4.99),
        ("Hot Cappuccino", 4.49),
        ("Berry Smoothie", 5.99),
        ("House Soda", 2.99)
    ].map { title, price in
        MenuItem(title: title, price: price, menuCategory: .drink,
                 ordersCount: Int.random(in: 0...500), ingredients: [])
    }

    static let dessertItems: [MenuItem] = [
        ("Chocolate Cake", 6.99),
        ("Cheesecake", 7.49),
        ("Tiramisu", 7.99),
        ("Fruit Tart", 5.99)
    ].map { title, price in
        MenuItem(title: title, price: price, menuCategory: .dessert,
                 ordersCount: Int.random(in: 0...500), ingredients: [])
    }
}
