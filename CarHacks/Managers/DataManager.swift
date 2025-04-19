//
//  DataManager.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 18.04.2025.
//

import Foundation

class DataManager {
    private static let postsKey = "savedPosts"
    
    // Сохранение всех постов
    static func savePosts(_ posts: [Post]) {
        if let encoded = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(encoded, forKey: postsKey)
        }
    }
    
    // Загрузка всех постов
    static func loadPosts() -> [Post] {
        if let data = UserDefaults.standard.data(forKey: postsKey),
           let decoded = try? JSONDecoder().decode([Post].self, from: data) {
            return decoded
        }
        return []
    }
    
    // Добавление нового поста
    static func addPost(_ post: Post) {
        var posts = loadPosts()
        posts.append(post)
        savePosts(posts)
    }
    
    // Очистка данных (для тестов)
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: postsKey)
    }
}
