//
//  DataManager.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 18.04.2025.
//

import Foundation

class DataManager {
    // Ключи для UserDefaults
    private enum Keys {
        static let posts = "savedPosts"
        static let brands = "savedBrands"
    }
    
    // Сохраняем посты
    static func savePosts(_ posts: [Post]) {
        if let encoded = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(encoded, forKey: Keys.posts)
        }
    }
    
    static func loadPosts() -> [Post] {
        if let data = UserDefaults.standard.data(forKey: Keys.posts),
           let decoded = try? JSONDecoder().decode([Post].self, from: data) {
            return decoded
        }
        return [] // Если данных нет, вернем пустой массив
    }
    
    static func saveBrands(_ brands: [CarBrand]) {
        if let encoded = try? JSONEncoder().encode(brands) {
                    UserDefaults.standard.set(encoded, forKey: Keys.posts)
                }
    }
    static func loadBrands() -> [CarBrand] {
        if let data = UserDefaults.standard.data(forKey: Keys.posts),
                   let decoded = try? JSONDecoder().decode([CarBrand].self, from: data) {
                    return decoded
                }
                return []
    }
}
