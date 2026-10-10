//
//  Menuitemdetailsview .swift
//  Little Lemon dinner menu
//
//  Created by Valentyn Verovkin on 25.07.2026.
//
import SwiftUI

// Task 1: Detail screen shown when a menu item cell is tapped (matches wireframe:
// item title, centered Little Lemon logo, then centered Price / Ordered / Ingredients).
//
// Note: add LittleLemonLogo.png (included alongside this file) to your project's
// Assets.xcassets as an image set named "LittleLemonLogo" for the Image(...) below
// to resolve.
struct MenuItemDetailsView: View {
    let item: MenuItem

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(item.title)
                    .font(.largeTitle.bold())
                    .padding(.top, 8)

                Image("LittleLemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 220)

                VStack(spacing: 20) {
                    detailBlock(label: "Price:", value: item.price.formatted(.number.precision(.fractionLength(2))))
                    detailBlock(label: "Ordered:", value: "\(item.ordersCount)")

                    VStack(spacing: 4) {
                        Text("Ingredients:")
                            .font(.headline)
                        ForEach(item.ingredients) { ingredient in
                            Text(ingredient.rawValue)
                                .font(.body)
                        }
                    }
                }
                .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        // Back button automatically reads "Menu" from MenuItemsView's navigationTitle.
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailBlock(label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.headline)
            Text(value)
                .font(.body)
        }
    }
}

#Preview {
    NavigationStack {
        MenuItemDetailsView(item: MockData.foodItems[0])
    }
}
