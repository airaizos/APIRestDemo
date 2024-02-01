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
    
    //MARK: Characters CollectionView
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
    
    func addCharacters() async {
     let offset = Int.random(in: 0..<1565)
        do {
            let fetchedCharacters = try await network.getCharacters(offset: offset).filter { item in
                item.thumbnailURL.path.hasSuffix("image_not_available") ? false : true
            }
            let cellCharacter = try await network.getImages(from: fetchedCharacters)
            characters.append(contentsOf: cellCharacter)
        } catch {
            print("Error en pantalla addCharacters")
        }
    }
    
    func toggleFavorite(_ marvelCharacter: MarvelCellCharacter) {
        guard var selected = characters.first(where: { $0.id == marvelCharacter.id }), let index = characters.firstIndex(of: selected) else { return }
        selected.favorite.toggle()
        if favorites.contains(selected) {
            favorites.removeAll(where: {$0.id == selected.id })
            characters[index].favorite = false
        } else {
            favorites.append(selected)
            characters[index].favorite = true
        }
        
    }
    
    
    //MARK: Favorites CollectionView
    private var favorites = [MarvelCellCharacter]() {
        didSet {
            NotificationCenter.default.post(name: .marvelFavoritesChar, object:  nil)
        }
    }
    
    var favoritesSnapshot: NSDiffableDataSourceSnapshot<Int,MarvelCellCharacter> {
        var snapshot = NSDiffableDataSourceSnapshot<Int,MarvelCellCharacter>()
        snapshot.appendSections([0])
        snapshot.appendItems(favorites,toSection: 0)
        return snapshot
    }
    
}
