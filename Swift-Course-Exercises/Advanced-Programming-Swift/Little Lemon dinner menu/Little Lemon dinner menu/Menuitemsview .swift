//
//  Menuitemsview .swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//

import SwiftUI

// Task 1: Main menu screen — grid of items grouped by category (matches wireframe:
// "Food" / "Drinks" / "Dessert" section headers, 3-column grid of image placeholders
// with the item title underneath).
// Task 2: Nav bar filter button presents MenuItemsOptionView as a sheet.
struct MenuItemsView: View {
    @StateObject private var viewModel = MenuViewViewModel()
    @State private var showingOptions = false

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(MenuCategory.allCases) { category in
                        let items = viewModel.items(for: category)
                        if !items.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(sectionTitle(for: category))
                                    .font(.title2.bold())

                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(items) { item in
                                        NavigationLink(value: item) {
                                            MenuItemGridCell(item: item)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Menu")
            .navigationDestination(for: MenuItem.self) { item in
                MenuItemDetailsView(item: item)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingOptions = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showingOptions) {
                MenuItemsOptionView(
                    selectedCategories: $viewModel.selectedCategories,
                    sortOption: $viewModel.sortOption
                )
            }
        }
    }

    // Wireframe labels the drinks section "Drinks" (plural) even though the
    // enum case/category is "Drink" — map that here rather than renaming the enum.
    private func sectionTitle(for category: MenuCategory) -> String {
        category == .drink ? "Drinks" : category.rawValue
    }
}

private struct MenuItemGridCell: View {
    let item: MenuItem

    var body: some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
                .aspectRatio(1, contentMode: .fit)

            Text(item.title)
                .font(.footnote)
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
    }
}

// MenuItem needs to be Hashable for navigationDestination(for:)
extension MenuItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#Preview {
    MenuItemsView()
}
