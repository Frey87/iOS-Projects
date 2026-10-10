//
//  ContentView.swift
//  Displaying a list Little Lemon Reservations Application
//
//  Created by Valentyn Verovkin on 28.06.2026.
//

import SwiftUI
import Combine

struct Item: Identifiable {
    let id = UUID()
    let name: String
}

class Model: ObservableObject {
    @Published var menuItems: [Item] = Model.menuItems()

    static func menuItems() -> [Item] {
        return [
            Item(name: "Lasagna"),
            Item(name: "Fettuccini Alfredo"),
            Item(name: "Spaghetti"),
            Item(name: "Avocado Toast"),
            Item(name: "Tortellini"),
            Item(name: "Pizza")
        ]
    }
}

struct ContentView: View {
    @ObservedObject private var model = Model()

    var body: some View {
        VStack {
            List {
                ForEach(model.menuItems) { item in
                    Text(item.name)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
