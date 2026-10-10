//
//  MainView.swift
//  Lemon App View Exercise
//
//  Created by Valentyn Verovkin on 21.06.2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.orange
                            .ignoresSafeArea()
                    HStack(spacing: 8) {
                        Text("Demo").scaledToFit().frame(
                            width: 100, height: 100, alignment: .center)
                        VStack(spacing: 10) {
                            Text("Little Lemon").font(.title)
                            Text("Tomato Tortellini, Bottarga and Carbonara ").font(.title3)
                                .multilineTextAlignment(.center)
                        }// :- VStack
                            .padding()
                    }  // :- HStack
                    .padding()
                }  // :- ZStack
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

