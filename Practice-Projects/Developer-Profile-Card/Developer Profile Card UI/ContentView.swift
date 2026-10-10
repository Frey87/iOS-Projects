//
//  ContentView.swift
//  Developer Profile Card UI
//
//  Created by Valentyn Verovkin on 05.07.2026.
//

import SwiftUI

struct Skill: Identifiable {
    let id = UUID()
    let name: String
    let level: String
}

struct ContentView: View {
    
    @State private var count = 0

    let skills: [Skill] = [
        Skill(name: "Swift", level: "Beginner"),
        Skill(name: "SwiftUI", level: "Beginner"),
        Skill(name: "Xcode", level: "Learning"),
        Skill(name: "Git", level: "Familiar")
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("My Profile")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.white)
                }
                
                VStack(spacing: 4) {
                    Text("Jane Developer")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text("iOS Enthusiast")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                
                HStack(spacing: 16) {
                    StatCard(number: "12", label: "Projects")
                    StatCard(number: "48", label: "Commits")
                    StatCard(number: "5", label: "Stars")
                }
                
                HStack {
                    Text("Tap count: \(count)")
                        .foregroundStyle(.blue)
                    
                    Spacer()
                    
                    Button("Tap me") {
                        count += 1
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                
                Divider()
                    .background(Color.gray.opacity(0.6))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Skills")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    List {
                        ForEach(skills) { skill in
                            HStack {
                                Text(skill.name)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Text(skill.level)
                                    .foregroundStyle(.gray)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .frame(height: 250)
                    .scrollContentBackground(.hidden)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.top, 4)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

// Reusable Stat Card
struct StatCard: View {
    
    let number: String
    let label: String
    
    var body: some View {
        VStack {
            Text(number)
                .font(.headline)
                .foregroundStyle(.white)
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

#Preview {
    ContentView()
}
