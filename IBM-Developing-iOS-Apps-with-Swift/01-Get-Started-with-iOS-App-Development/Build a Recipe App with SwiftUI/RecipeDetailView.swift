//
//  RecipeDetailView.swift
//  Build a Recipe App with SwiftUI
//
//  Created by Valentyn Verovkin on 05.07.2026.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(recipe.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(recipe.isFavorite ? .red : .gray)

                    Text(recipe.isFavorite ? "Favorite recipe" : "Not in favorites")
                        .font(.headline)
                }

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()

                Text(recipe.description)
                    .font(.body)

                Text("Ingredients")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                    }
                }

                Button {
                    recipe.isFavorite.toggle()
                } label: {
                    Text(recipe.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(recipe.isFavorite ? Color.red : Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            recipe: .constant(
                Recipe(
                    name: "Margherita Pizza",
                    description: "Classic Italian pizza with tomato, mozzarella, and basil.",
                    ingredients: ["Pizza dough", "Tomato sauce", "Mozzarella", "Fresh basil", "Olive oil"],
                    imageName: "spaghetti",
                    isFavorite: true
                )
            )
        )
    }
}
