//
//  HomeView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var posts = DataManager.loadPosts()
    @State private var brands = CarBrand.sampleBrands()
  
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Заголовок
                    HStack {
                        Text("Главная")
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink {
                            AddPostView()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    // Быстрый доступ
                    SectionHeader(title: "Мои записи", action: {
                     AnyView(NavigationLink("Все", destination: PostsListView()))
                    })
                    
                    RecentPostsPreview(posts: Array(posts.prefix(3)))
                    
                    // Популярные марки
                    SectionHeader(title: "Популярные марки", action: {
                        AnyView(NavigationLink("Популярные марки", destination: PopularBrandsView(brands: brands)))
                    }
                    )
                    
                }
                .padding()
            }
            .refreshable {
                posts = DataManager.loadPosts()
            }
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
        }
    }
}

// MARK: - Компоненты

struct SectionHeader: View {
    let title: String
    var action: (() -> AnyView)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
            
            Spacer()
            
            if let action = action {
                action()
            }
        }
    }
}

struct RecentPostsPreview: View {
    let posts: [Post]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                if posts.isEmpty {
                    Text("Пока нет записей")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(posts) { post in
                        NavigationLink(value: post) {
                            PostPreviewCard(post: post)
                        }
                    }
                }
            }
        }
    }
}

struct PostPreviewCard: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = post.images.first {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipped()
                    .cornerRadius(8)
            } else {
                ZStack {
                    Color.gray.opacity(0.2)
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
                .frame(width: 150, height: 100)
                .cornerRadius(8)
            }
            
            Text(post.title)
                .font(.headline)
                .frame(width: 150)
                .lineLimit(1)
            
            Text(post.category)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct PopularBrandsView: View {
    let brands: [CarBrand] // Теперь принимает параметр
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(brands.prefix(5)) { brand in // Показываем только 5 популярных
                    NavigationLink(value: brand) {
                        BrandLogoView(brand: brand)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BrandLogoView: View {
    let brand: CarBrand
    
    var body: some View {
        VStack {
            Image(systemName: brand.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            
            Text(brand.name)
                .font(.headline)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

// MARK: - Предварительный просмотр

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

#Preview {
    HomeView()
}
