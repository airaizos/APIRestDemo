//
//  MarvelCharactersCollectionViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import SwiftUI

final class MarvelCharactersCollectionViewController: UICollectionViewController {

    let modelLogic = MarvelCharactersModelLogic.shared
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Int,MarvelCellCharacter> = {
        UICollectionViewDiffableDataSource<Int,MarvelCellCharacter>(collectionView: collectionView) { [self] collectionView, indexPath, character in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvelCharacterCell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                MarvelCharacterCellView(character: character)
            }
            return cell
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        
        dataSource.apply(modelLogic.snapshot,animatingDifferences: true)
        
        NotificationCenter.default.addObserver(forName: .marvelCharacters, object: nil, queue: .main) { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
            self?.collectionView.reloadData()
            if let snapshot = self?.modelLogic.snapshot {
                
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let marvelCharacter = dataSource.itemIdentifier(for: indexPath) else { return }
        modelLogic.toggleFavorite(marvelCharacter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            await modelLogic.addCharacters()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .marvelCharacters, object: nil)
    }
}


extension Notification.Name {
    static let marvelCharacters = Notification.Name("MRVLCHAR")
    static let marvelFavoritesChar = Notification.Name("MRVLFAV")
}
