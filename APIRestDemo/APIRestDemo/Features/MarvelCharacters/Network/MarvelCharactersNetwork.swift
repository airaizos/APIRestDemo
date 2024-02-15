//
//  MarvelCharactersNetwork.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import UIKit

final class MarvelCharactersNetwork {
    static let shared = MarvelCharactersNetwork()
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCharacters(offset:Int) async throws -> [MarvelCharacter] {
        let result = try await getJSONAsAw(url: .marvelCharacters(offset: offset), type: MarvelResults.self)
        
        return result.data.results
    }
    
    func getImage(from character: MarvelCharacter) async throws -> UIImage {
        guard !character.thumbnailURL.path.hasSuffix("image_not_available") else { return UIImage(named: "notAvailable")! }
        
        return try await fetchImage(url: .characterThumbnail(character.thumbnailURL), session: session)
            .byPreparingThumbnail(ofSize: CGSize(width: 300, height: 300))
        ?? UIImage(named: "notAvailable")!
    }
    
    
    ///Crea las tareas para la creación de cada Elemento, para lanzarlo después de manera concurrente
    func getImages(from characters:[MarvelCharacter]) async throws -> [MarvelCellCharacter] {
        return try await withThrowingTaskGroup(of: MarvelCellCharacter.self, returning: [MarvelCellCharacter].self) { group in
            for character in characters {
                group.addTask {
                    let thumbnail =  try await self.getImage(from: character)
                    return MarvelCellCharacter(uuid: UUID(),id: character.id, name: character.name, thumbnail: thumbnail)
                }
            }
            var result:[MarvelCellCharacter] = []
            
            for try await character in group {
                result.append(character)
            }
            return result
        }
    }
}
