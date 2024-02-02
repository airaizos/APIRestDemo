//
//  DiceBearEmojiModel.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 2/2/24.
//

import UIKit
import CoreData

struct DiceBearEmojiModel {
    let id: UUID
    let image: UIImage
    let details: String
    let createdAt: Date
    
    init(id: UUID? = UUID(), image: UIImage, details: String? = "", createdAt: Date? = Date.now) {
        self.id = id ?? UUID()
        self.image = image
        self.details = details ?? ""
        self.createdAt = createdAt ?? Date.now
    }
}

extension DiceBearEmojiModel {
    func getEmojiEntityItem(from emoji: DiceBearEmojiModel, in context: NSManagedObjectContext) -> EmojiEntity {
        let newItem = EmojiEntity(context: context)
        newItem.id = emoji.id
        newItem.imageData = emoji.image.pngData()
        newItem.details = emoji.details
        newItem.createdAt = emoji.createdAt
        
        return newItem
    }
}
