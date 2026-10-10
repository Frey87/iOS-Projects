//
//  ContentView.swift
//  Navigation Little Lemon Reservations Application
//
//  Created by Valentyn Verovkin on 28.06.2026.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Exercise 1")

                NavigationLink(destination: NewView()) {
                    Text("Do something")
                }
            }
            .navigationTitle("Little Lemon")
        }
    }
}

struct NewView: View {
    var body: some View {
        MyTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
