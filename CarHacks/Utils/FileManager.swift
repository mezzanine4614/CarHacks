//
//  FileManager.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 19.04.2025.
//

import UIKit

extension FileManager {
    // Базовый URL для сохранения
    static var documentsDirectory: URL {
        return FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
    }
    
    // Сохранение изображения
    static func saveImage(_ image: UIImage) -> String? {
        let fileName = "IMG_\(UUID().uuidString).jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = image.jpegData(compressionQuality: 0.7) {
            do {
                try data.write(to: fileURL)
                return fileName
            } catch {
                print("Ошибка сохранения фото: \(error)")
                return nil
            }
        }
        return nil
    }
    
    // Загрузка изображения
    static func loadImage(path: String) -> UIImage? {
        let url = documentsDirectory.appendingPathComponent(path)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    // Удаление файла
    static func deleteFile(path: String) {
        let url = documentsDirectory.appendingPathComponent(path)
        try? FileManager.default.removeItem(at: url)
    }
    
    // Для отладки: список всех файлов
    static func listAllFiles() {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: documentsDirectory.path)
            print("Сохранённые файлы: \(files)")
        } catch {
            print("Ошибка чтения файлов: \(error)")
        }
    }
}


