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
    
}
