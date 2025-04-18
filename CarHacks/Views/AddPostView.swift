//
//  AddPostView.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import SwiftUI
import PhotosUI

struct AddPostView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    @State private var showImagePicker = false
    
    let selectedModel: String?
    
    init(selectedModel: String? = nil) {
        self.selectedModel = selectedModel
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Секция с информацией о модели, если она указана
                if let model = selectedModel {
                    Section(header: Text("Модель автомобиля")) {
                        Text(model)
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("Информация о записи")) {
                    TextField("Название записи", text: $title)
                    TextField("Подробное описание", text: $description, axis: .vertical)
                }
                
                Section(header: Text("Медиа")) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Label("Добавить фото/видео", systemImage: "photo")
                    }
                    
                    if !selectedImages.isEmpty {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Button("Опубликовать") {
                        // Здесь будет логика сохранения
                        print("""
                                            Пост опубликован:
                                            Модель: \(selectedModel ?? "Не указана")
                                            Название: \(title)
                                            Описание: \(description)
                                            """)
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                }
            }
            .navigationTitle(selectedModel != nil ? "Новая запись" : "Новая запись по модели")
            .photosPicker(isPresented: $showImagePicker, selection: $selectedItems, matching: .any(of: [.images, .videos]))
            .onChange(of: selectedItems) { _ in
                Task {
                    selectedImages.removeAll()
                    
                    for item in selectedItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                selectedImages.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddPostView()
}
