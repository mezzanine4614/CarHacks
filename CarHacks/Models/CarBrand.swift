//
//  CarBrand.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import Foundation

struct CarBrand: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let logo: String
    let description: String
    let models: [CarModel]
}

struct CarModel: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let year: Int
    let image: String
    let description: String
}


