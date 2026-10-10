//
//  Menuviewviewmodel.swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import Foundation
import Combine

// Task 6: Stores the business logic / state for MenuItemsView.
final class MenuViewViewModel: ObservableObject {
    @Published var foodMenuItems: [MenuItem]
    @Published var drinkMenuItems: [MenuItem]
    @Published var dessertMenuItems: [MenuItem]

    // Drives MenuItemsOptionView (Task 2)
    @Published var selectedCategories: Set<MenuCategory> = Set(MenuCategory.allCases)
    @Published var sortOption: SortOption = .mostPopular

    init(
        foodMenuItems: [MenuItem] = MockData.foodItems,
        drinkMenuItems: [MenuItem] = MockData.drinkItems,
        dessertMenuItems: [MenuItem] = MockData.dessertItems
    ) {
        self.foodMenuItems = foodMenuItems
        self.drinkMenuItems = drinkMenuItems
        self.dessertMenuItems = dessertMenuItems
    }

    /// Menu items grouped by category, filtered by the selected categories
    /// and sorted according to the current SortOption. Used by MenuItemsView.
    func items(for category: MenuCategory) -> [MenuItem] {
        guard selectedCategories.contains(category) else { return [] }

        let items: [MenuItem]
        switch category {
        case .food: items = foodMenuItems
        case .drink: items = drinkMenuItems
        case .dessert: items = dessertMenuItems
        }

        switch sortOption {
        case .mostPopular:
            return items.sorted { $0.ordersCount > $1.ordersCount }
        case .price:
            return items.sorted { $0.price < $1.price }
        case .aToZ:
            return items.sorted { $0.title < $1.title }
        }
    }
}
