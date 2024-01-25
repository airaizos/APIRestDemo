//
//  EmojiEntityExtensions.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 25/1/24.
//

import UIKit
import CoreData

extension EmojiEntity {
    var emojiModel: DiceBearEmojiModel? {
        guard let imageData, let image = UIImage(data: imageData) else { return  nil }
        
        return DiceBearEmojiModel(id: id, image: image, details: details, createdAt: createdAt)
    }

}
