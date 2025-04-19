//
//  CarBrand.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import Foundation

struct CarBrand: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let logo: String
    let description: String
    var models: [CarModel] = []
    
    static func sampleBrands() -> [CarBrand] {
        [
            CarBrand(
                name: "Toyota",
                logo: "t.circle.fill",
                description: "Японский производитель",
                models: CarModel.sampleToyotaModels()
            ),
            CarBrand(
                name: "BMW",
                logo: "b.circle.fill",
                description: "Немецкий производитель",
                models: CarModel.sampleBMWModels()
            )
        ]
    }
}

struct CarModel: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let year: Int
    let description: String?
    
    static func sampleToyotaModels() -> [CarModel] {
        [CarModel(name: "Camry", year: 2022, description: "_"), CarModel(name: "RAV4", year: 2023, description: "_")]
    }
    
    static func sampleBMWModels() -> [CarModel] {
        [CarModel(name: "3 Series", year: 2023, description: "_"), CarModel(name: "X5", year: 2022, description: "_")]
    }
}

