//
//  BrandsView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI

import SwiftUI

struct BrandsView: View {
    @State private var brands = CarBrand.sampleBrands() // Загружаем тестовые данные
    
    var body: some View {
        NavigationStack {
            List(brands) { brand in
                NavigationLink(value: brand) {
                    BrandRow(brand: brand)
                }
            }
            .navigationTitle("Марки автомобилей")
            .navigationDestination(for: CarBrand.self) { brand in
                BrandRow(brand: brand)
            }
            .refreshable {
                // Здесь может быть загрузка данных из сети
                brands = CarBrand.sampleBrands()
            }
        }
    }
}

struct BrandRow: View {
    let brand: CarBrand
    
    var body: some View {
        HStack {
            Image(systemName: brand.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
            
            Text(brand.name)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    BrandsView()
}
