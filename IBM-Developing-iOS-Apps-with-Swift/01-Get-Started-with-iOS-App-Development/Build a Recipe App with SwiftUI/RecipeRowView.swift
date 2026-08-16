//
//  RecipeRowView.swift
//  Build a Recipe App with SwiftUI
//
//  Created by Valentyn Verovkin on 05.07.2026.
//

import SwiftUI

struct RecipeRowView: View {
    @Binding var recipe: Recipe

    var body: some View {
        HStack(spacing: 12) {
            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.name)
                    .font(.headline)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Button {
                recipe.isFavorite.toggle()
            } label: {
                Image(
                    systemName: recipe.isFavorite
                        ? "heart.fill"
                        : "heart"
                )
                .foregroundStyle(
                    recipe.isFavorite ? .red : .gray
                )
                .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    RecipeRowView(
        recipe: .constant(
            Recipe(
                name: "Spaghetti Carbonara",
                description: "Classic Italian pasta",
                ingredients: [
                    "Pasta",
                    "Eggs",
                    "Bacon",
                    "Cheese"
                ],
                imageName: "spaghetti",
                isFavorite: true
            )
        )
    )
}
