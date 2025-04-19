//
//  Post.swift
//  CarHacks
//
//  Created by Smart Castle M1A2001 on 06.04.2025.
//

import Foundation
import SwiftUI
import UIKit

struct Post: Identifiable, Hashable, Codable {
    let id = UUID()
        var title: String
        var description: String
        var model: String?
        var category: String
        var imagePaths: [String]  // Храним пути вместо UIImage
        var date: Date
    
    var images: [UIImage] {
           imagePaths.compactMap { FileManager.loadImage(path: $0) }
       }

    mutating func addImage(_ image: UIImage) {
          if let path = FileManager.saveImage(image) {
              imagePaths.append(path)
          }
      }
    
    // Удаление изображения
    mutating func removeImage(at index: Int) {
        let path = imagePaths.remove(at: index)
        FileManager.deleteFile(path: path)
    }
}

enum MediaType {
    case photo(UIImage)
    case video(URL)
}


