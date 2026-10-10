//
//  MyTabView.swift
//  Navigation Little Lemon Reservations Application
//
//  Created by Valentyn Verovkin on 28.06.2026.
//

import SwiftUI

struct MyTabView: View {
    var body: some View {
        VStack {
            TabView {
                Text("This is the Share View")
                    .tabItem {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }

                Text("Trash Tab")
                    .tabItem {
                        Label("", systemImage: "trash")
                    }
            }
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
