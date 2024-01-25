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
    
    private var favoriteAvatars = [DiceBearAvatarModel]() {
        didSet {
            NotificationCenter.default.post(name: .favoritesChange, object: nil)
        }
    }
    
    init(persistence: DiceBearPersistence = .shared) {
        self.persistence = persistence
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
        favoriteAvatars.count
    }
    
    func addFavorite(avatar: DiceBearAvatarModel) {
        favoriteAvatars.insert(avatar, at: 0)
    }
    
    func getAvatarFrom(_ indexPath: IndexPath) -> UIImage? {
        let id = favoriteAvatars[indexPath.row].id
        let avatar = favoriteAvatars.first { avatar in
            avatar.id == id
        }
        return avatar?.image
    }
    
}
