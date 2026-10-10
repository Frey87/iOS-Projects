//
//  Ingredient.swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//

import Foundation
 
// Task 3.2 & 3.3: Ingredient enum, adopts the String protocol (RawRepresentable via String)
enum Ingredient: String, CaseIterable, Identifiable, Equatable {
    case spinach = "Spinach"
    case broccoli = "Broccoli"
    case carrot = "Carrot"
    case pasta = "Pasta"
    case tomatoSauce = "Tomato Sauce"
 
    var id: String { rawValue }
}
