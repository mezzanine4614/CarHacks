//
//  Post.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import Foundation
import SwiftUI
import UIKit

struct Post: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let model: String?
    let category: String
    let images: [String]
    let date: Date
    
}

let samplePosts: [Post] = [
    Post(
        title: "Замена масла в двигателе",
        description: "Пошаговая инструкция по замене масла в Toyota Camry",
        model: "Toyota Camry",
        category: "Обслуживание",
        images: [],
        date: Date()
    ),
    Post(
        title: "Как сэкономить топливо",
        description: "10 советов по экономии топлива для любого автомобиля",
        model: nil,
        category: "Лайфхак",
        images: [],
        date: Date()
    ),
    
    Post(
        title: "Ремонт подвески",
        description: "Как заменить амортизаторы",
        model: "BMW X5",
        category: "Ремонт",
        images: [],
        date: Date()
    ),
    Post(
        title: "Экономия топлива",
        description: "10 советов по уменьшению расхода",
        model: nil, // Общий совет
        category: "Лайфхак",
        images: [],
        date: Date()
    )
]

enum MediaType {
    case photo(UIImage)
    case video(URL)
}
