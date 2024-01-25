//
//  DiceBearModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import UIKit

final class DiceBearModelLogic {
    static let shared = DiceBearModelLogic()
    
    let persistence: DiceBearPersistence
    var emojiDataBase: APIRestDemoDataBase
    
    private var favoriteEmojis = [DiceBearEmojiModel]() {
        didSet {
            NotificationCenter.default.post(name: .favoritesChange, object: nil)

        }
    }
    
    init(persistence: DiceBearPersistence = .shared, emojiDataBase: APIRestDemoDataBase = .shared) {
        self.persistence = persistence
        self.emojiDataBase = emojiDataBase
        loadFavoritesEmojis()
    }
    
    func getEmoji() async throws -> UIImage {
       try await persistence.getFunEmoji()
    }
    
    func refreshEmoji(params: DiceBearModel) async throws -> UIImage {
        try await persistence.getEmojiWithOptions(params)
    }
    
    func getRandomEmoji() async throws -> UIImage {
        let randomModel = DiceBearModel.randomModel()
        return try await persistence.getEmojiWithOptions(randomModel)
    }
    
    //MARK: Favorites
    func getFavoritesCount() -> Int {
        favoriteEmojis.count
    }
    
    func addFavorite(emoji: DiceBearEmojiModel) throws {
        favoriteEmojis.insert(emoji, at: 0)
        try emojiDataBase.insert(emoji: emoji)
        
    }
    
    func getEmojiFrom(_ indexPath: IndexPath) -> UIImage? {
        let id = favoriteEmojis[indexPath.row].id
        let emoji = favoriteEmojis.first { emoji in
            emoji.id == id
        }
        return emoji?.image
    }
    
    //MARK: DataBase
    func loadFavoritesEmojis() {
        do {
            let savedEmojis = try emojiDataBase.fetchEmojis()
            favoriteEmojis = savedEmojis
        } catch {
            favoriteEmojis = []
        }
    }
    
    
}
