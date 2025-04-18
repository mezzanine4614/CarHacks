//
//  BrandsView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI

struct BrandsView: View {
    let brands: [CarBrand] = [
    CarBrand(
        name: "Toyota",
        logo: "t.circle.fill",
        description: "Японский производитель",
        models: [
            CarModel(name: "Camry", year: 2022, image: "car.fill", description: "Седан бизнес-класса"),
            CarModel(name: "RAV4", year: 2023, image: "car.fill", description: "Компактный кроссовер"),
            CarModel(name: "Land Cruiser", year: 2021, image: "car.fill", description: "Внедорожник премиум-класса")
        ]
    ),
    
    CarBrand(
                name: "BMW",
                logo: "b.circle.fill",
                description: "Немецкий производитель",
                models: [
                    CarModel(name: "3 Series", year: 2023, image: "car.fill", description: "Спортивный седан"),
                    CarModel(name: "X5", year: 2022, image: "car.fill", description: "Премиум SUV")
                ]
            ),
    
    CarBrand(
                name: "Chevrolet",
                logo: "c.circle.fill",
                description: "Американо-корейский производитель",
                models: [
                    CarModel(name: "Aveo", year: 2014, image: "car.fill", description: "компактный хетчбек"),
                    CarModel(name: "Malibu", year: 2022, image: "car.fill", description: "Премиум-седан")
                ]
            ),
    
    CarBrand(
                name: "Daewoo",
                logo: "d.circle.fill",
                description: "Корейский производитель",
                models: [
                    CarModel(name: "Nexia", year: 2012, image: "car.fill", description: "Седан B-класса"),
                    CarModel(name: "Gentra", year: 2014, image: "car.fill", description: "Седан С-класса"),
                ]
            )
    ]
    
    var body: some View {
            NavigationStack {
                List(brands) { brand in
                    NavigationLink(value: brand) {
                        HStack {
                            Image(systemName: brand.logo)
                                .foregroundColor(.blue)
                            Text(brand.name)
                        }
                    }
                }
                .navigationTitle("Марки автомобилей")
                .navigationDestination(for: CarBrand.self) { brand in
                    BrandDetailView(brand: brand)
                }
            }
        }
    }

struct BrandDetailView: View {
    let brand: CarBrand
    
    var body: some View {
        List {
            // Информация о марке
            Section {
                VStack(spacing: 20) {
                    Image(systemName: brand.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    Text(brand.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(brand.description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
            }
            
            // Список моделей
            Section(header: Text("Модели")) {
                ForEach(brand.models) { model in
                    NavigationLink(value: model) {
                        HStack {
                            Image(systemName: model.image)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(model.name)
                                    .font(.headline)
                                Text("\(model.year) год")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(brand.name)
        .navigationDestination(for: CarModel.self) { model in
            ModelDetailView(model: model, brandName: brand.name)
        }
    }
}

struct ModelDetailView: View {
    let model: CarModel
    let brandName: String
    @State private var showAddPost = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: model.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)
            
            VStack(spacing: 8) {
                Text(brandName)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text(model.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("\(model.year) год")
                    .font(.title3)
            }
            
            Text(model.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                showAddPost = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Добавить запись по \(model.name)")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle(model.name)
        .sheet(isPresented: $showAddPost) {
            AddPostView(selectedModel: "\(brandName) \(model.name)")
        }
    }
}


#Preview {
    BrandsView()
}
