//
//  Menuitemsoptionview.swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import SwiftUI

// Task 2: Presented from MenuItemsView's filter button (matches wireframe: "Filter"
// title, "Done" button, two sections built from enums — MenuCategory and SortOption).
struct MenuItemsOptionView: View {
    @Binding var selectedCategories: Set<MenuCategory>
    @Binding var sortOption: SortOption
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("SELECTED CATEGORIES")) {
                    ForEach(MenuCategory.allCases) { category in
                        Button {
                            toggle(category)
                        } label: {
                            HStack {
                                Text(category.rawValue)
                                    .foregroundStyle(.primary)
                                Spacer()
                                if selectedCategories.contains(category) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.tint)
                                }
                            }
                        }
                    }
                }

                Section(header: Text("SORT BY")) {
                    ForEach(SortOption.allCases) { option in
                        Button {
                            sortOption = option
                        } label: {
                            HStack {
                                Text(option.rawValue)
                                    .foregroundStyle(.primary)
                                Spacer()
                                if sortOption == option {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.tint)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func toggle(_ category: MenuCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

#Preview {
    MenuItemsOptionView(
        selectedCategories: .constant(Set(MenuCategory.allCases)),
        sortOption: .constant(.mostPopular)
    )
}
