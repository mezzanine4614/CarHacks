//
//  PostsListView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 19.04.2025.
//

import SwiftUI

import SwiftUI

struct PostsListView: View {
    @State private var posts = DataManager.loadPosts()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($posts) { $post in
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        PostRow(post: post)
                    }
                }
                .onDelete(perform: deletePost)
            }
            .navigationTitle("Мои записи")
            .toolbar {
                NavigationLink {
                    AddPostView()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .onAppear {
                posts = DataManager.loadPosts()
            }
        }
    }
    
    private func deletePost(at offsets: IndexSet) {
        posts.remove(atOffsets: offsets)
        DataManager.savePosts(posts)
    }
}

struct PostRow: View {
    let post: Post
    
    var body: some View {
        HStack {
            if let firstImage = post.images.first {
                Image(uiImage: firstImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.headline)
                Text(post.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(post.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
                Text(post.title)
                    .font(.title)
                
                Text(post.description)
                    .font(.body)
                
                HStack {
                    Text(post.category)
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(5)
                    
                    Text(post.date.formatted())
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle(post.title)
    }
}
#Preview {
    PostsListView()
}
