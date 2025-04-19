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
    @State private var selectedCategory = "Ремонт"
    @State private var selectedImage: UIImage?
    @State private var selectedPhotoItem: PhotosPickerItem?
    
    let categories = ["Ремонт", "Обслуживание", "Лайфхак"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Информация") {
                    TextField("Название", text: $title)
                    TextField("Описание", text: $description)
                    Picker("Категория", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section("Изображение") {
                    PhotosPicker(
                        selection: $selectedPhotoItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Выбрать фото", systemImage: "photo")
                    }
                    .onChange(of: selectedPhotoItem) { _ in
                        loadImage()
                    }
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
                
                Button("Сохранить") {
                    savePost()
                }
                .disabled(title.isEmpty || description.isEmpty)
            }
            .navigationTitle("Новый пост")
        }
    }
    
    private func loadImage() {
        Task {
            if let item = selectedPhotoItem,
               let data = try? await item.loadTransferable(type: Data.self) {
                selectedImage = UIImage(data: data)
            }
        }
    }
    
    private func savePost() {
        var newPost = Post(
            title: title,
            description: description,
            model: nil,
            category: selectedCategory,
            imagePaths: [],
            date: Date()
        )
        
        if let image = selectedImage {
            newPost.addImage(image)
        }
        
        DataManager.addPost(newPost)
    }
}
#Preview {
    AddPostView()
}
