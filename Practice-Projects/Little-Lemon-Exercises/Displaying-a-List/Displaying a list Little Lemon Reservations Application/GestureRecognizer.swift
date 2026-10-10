//
//  GestureRecognizer.swift
//  Displaying a list Little Lemon Reservations Application
//
//  Created by Valentyn Verovkin on 28.06.2026.
//

import SwiftUI

struct GestureRecognizer: View {
    @State private var flag = false

    var body: some View {
        Text("Tap Me")
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(15)
            .background(flag ? Color.green : Color.yellow)
            .cornerRadius(10)
            .onTapGesture {
                flag.toggle()
            }
    }
}

#Preview {
    GestureRecognizer()
}
