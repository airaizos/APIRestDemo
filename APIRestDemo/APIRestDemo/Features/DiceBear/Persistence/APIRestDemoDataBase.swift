//
//  APIRestDemoDataBase.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 25/1/24.
//

import Foundation
import CoreData

final class APIRestDemoDataBase {
    static let shared = APIRestDemoDataBase()
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext = APIRestDemoContainer.shared.container.viewContext) {
        self.context = context
    }
}

//MARK: DiceBear
extension APIRestDemoDataBase {
    func fetchEmojis() throws -> [DiceBearEmojiModel] {
        let request = EmojiEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \EmojiEntity.createdAt, ascending: false)]
        do {
            let emojis = try context.fetch(request)
            return emojis.compactMap { $0.emojiModel }
        } catch {
           throw DataBaseError.fetch
        }
    }
    
    func insert(emoji: DiceBearEmojiModel) throws {
        let newEmojiEntityItem = emoji.getEmojiEntityItem(from: emoji, in: context)
        context.insert(newEmojiEntityItem)
        do {
            try context.save()
        } catch {
            throw DataBaseError.insert
        }
    }
}
