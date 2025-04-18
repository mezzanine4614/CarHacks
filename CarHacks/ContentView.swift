//
//  ContentView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
            
            BrandsView()
                .tabItem {
                    Label("Марки", systemImage: "car.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
