//
//  HomeView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showAddPost = false
    @State private var posts: [Post] = DataManager.loadPosts() // Загружаем при создании
    @State private var brands: [CarBrand] = DataManager.loadBrands()
    
    let recentPosts: [Post] = samplePosts // Примеры последних записей
   
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Приветствие с кнопкой добавления
                    HStack {
                        Text("Добро пожаловать!")
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        Button(action: { showAddPost = true }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    .padding(.bottom, 10)
                    
                    // Последние записи
                    SectionHeader(title: "Последние записи", showAll: true)
                    
                    RecentPostsView(posts: recentPosts)
                    
                    // Популярные марки
                    SectionHeader(title: "Популярные марки", showAll: false)
                    
                    PopularBrandsView()
                }
                .padding()
            }
            List(posts) { post in
                PostDetailView(post: post)
            }
            .onDisappear {
                DataManager.savePosts(posts) // Сохраняем при закрытии
            }
            .navigationTitle("Главная")
            .sheet(isPresented: $showAddPost) {
                AddPostView()
            }
        }
    }
}

struct SectionHeader: View {
    let title: String
    let showAll: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
            
            Spacer()
            
            if showAll {
                NavigationLink("Все") {
                    AllPostsView() // Покажем этот экран позже
                }
                .foregroundColor(.blue)
            }
        }
    }
}

// Превью последних записей
struct RecentPostsView: View {
    let posts: [Post]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(posts) { post in
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        PostCardView(post: post)
                    }
                }
            }
        }
    }
}

// Карточка записи
struct PostCardView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = post.images.first {
                Image(image) //Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 100)
                    .foregroundColor(.blue)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Text(post.title)
                            .font(.headline)
                            .frame(width: 150)
                            .lineLimit(1)
                        
                        Text(post.model ?? "Общий совет")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(width: 150)
                            .lineLimit(1)
                    }
                }
            }

struct PopularBrandsView: View {
    let brands = [
        CarBrand(name: "Toyota", logo: "t.circle.fill", description: "Японский производитель", models: [
            CarModel(name: "Camry", year: 2022, image: "car.fill", description: "Седан бизнес-класса"),
            CarModel(name: "RAV4", year: 2023, image: "car.fill", description: "Компактный кроссовер"),
            CarModel(name: "Land Cruiser", year: 2021, image: "car.fill", description: "Внедорожник премиум-класса")
            
        ]),
        CarBrand(name: "BMW", logo: "b.circle.fill", description: "Немецкий производитель", models: [
            CarModel(name: "3 Series", year: 2023, image: "car.fill", description: "Спортивный седан"),
            CarModel(name: "X5", year: 2022, image: "car.fill", description: "Премиум SUV")
        ]),
        CarBrand(name: "Chevrolet", logo: "c.circle.fill", description: "Американо-корейский производитель", models: [
            CarModel(name: "Aveo", year: 2014, image: "car.fill", description: "компактный хетчбек"),
            CarModel(name: "Malibu", year: 2022, image: "car.fill", description: "Премиум-седан")
        ])
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(brands) { brand in
                    // 1. Обернем в NavigationLink
                    NavigationLink(value: brand) {
                        VStack {
                            Image(systemName: brand.logo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                            
                            Text(brand.name)
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain) // Убираем стандартное выделение кнопки
                }
            }
            .padding(.horizontal)
        }
        .navigationDestination(for: CarBrand.self) { brand in
            BrandDetailView(brand: brand)
        }
    }
}

struct AllPostsView: View {
    let posts: [Post] = samplePosts
    
    var body: some View {
        List(posts) { post in
            NavigationLink {
                PostDetailView(post: post)
            } label: {
                HStack {
                    if let image = post.images.first {
                        Image(image) // Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipped()
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.model ?? "Общий совет")
                                                   .font(.subheadline)
                                                   .foregroundColor(.gray)
                                           }
                                       }
                                   }
                               }
                               .navigationTitle("Все записи")
                           }
                       }

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if !post.images.isEmpty {
                    TabView {
                        ForEach(post.images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .tabViewStyle(.page)
                                        .frame(height: 250)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        if let model = post.model {
                                            Text(model)
                                                .font(.title3)
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Text(post.title)
                                            .font(.largeTitle)
                                            .bold()
                                        
                                        HStack {
                                            Text(post.category)
                                                .padding(5)
                                                .background(Color.blue.opacity(0.2))
                                                .cornerRadius(5)
                                            
                                            Text(post.date.formatted(date: .abbreviated, time: .omitted))
                                                                        .foregroundColor(.gray)
                                                                }
                                                            }
                                                            
                                                            Text(post.description)
                                                                .font(.body)
                                                                .padding(.top, 10)
                
                Spacer()
                            }
                            .padding()
                        }
                        .navigationTitle(post.title)
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }



#Preview {
    HomeView()
}
