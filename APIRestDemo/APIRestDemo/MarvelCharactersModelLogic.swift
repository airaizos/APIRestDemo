//
//  MarvelCharactersModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import SwiftUI

final class MarvelCharactersModelLogic {
    static let shared = MarvelCharactersModelLogic()
    
    let network: MarvelCharactersNetwork
    
    init(network: MarvelCharactersNetwork = .shared) {
        self.network = network
    }
    
    private var characters = [MarvelCellCharacter]() {
        didSet {
            NotificationCenter.default.post(name: .marvelCharacters, object: nil)
        }
       
    }
      
    var snapshot: NSDiffableDataSourceSnapshot<Int,MarvelCellCharacter> {
        var snapshot = NSDiffableDataSourceSnapshot<Int,MarvelCellCharacter>()
        
        snapshot.appendSections([0])
        snapshot.appendItems(characters,toSection: 0)
        return snapshot
    }
    
    //MARK: CollectionView
    func getCharactersCount() -> Int {
        characters.count
    }
    
    func getCharacterFrom(indexPath: IndexPath) -> MarvelCellCharacter {
        characters[indexPath.row]
    }
    
    func addCharacters() async {
     let offset = Int.random(in: 0..<1565)
        do {
            let fetchedCharacters = try await network.getCharacters(offset: offset).filter { item in
                item.thumbnailURL.path.hasSuffix("image_not_available") ? false : true
                
            }
            let cellCharacter = try await network.getImages(from: fetchedCharacters)
            characters.insert(contentsOf: cellCharacter, at: 0)
        } catch {
            print("Error en pantalla addCharacters")
        }
        
    }
    
}
