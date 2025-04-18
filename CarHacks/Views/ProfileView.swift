//
//  ProfileView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = "Иван Иванов"
    @State private var email: String = "user@example.com"
    @State private var showEditProfile = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Аватар и информация
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    Text(username)
                        .font(.title)
                        .bold()
                    
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Кнопка редактирования
                    Button(action: {
                        showEditProfile = true
                    }) {
                        Text("Редактировать профиль")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Мои записи
                    Text("Мои записи")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    UserPostsView()
                }
                .padding()
            }
            .navigationTitle("Профиль")
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(username: $username, email: $email)
            }
        }
    }
}
struct EditProfileView: View {
    @Binding var username: String
    @Binding var email: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Основная информация")) {
                    TextField("Имя", text: $username)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                }
            }
                        .navigationTitle("Редактирование")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Готово") {
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }

struct UserPostsView: View {
    var body: some View {
        VStack(spacing: 10) {
            ForEach(1..<4) { index in
                HStack {
                    Image(systemName: "car.fill")
                        .foregroundColor(.blue)
                    Text("Мой совет по ремонту \(index)")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
    }
}

#Preview {
    ProfileView()
}
