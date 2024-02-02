//
//  MarvelFavoritesCollectionViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import SwiftUI

final class MarvelFavoritesCollectionViewController: UICollectionViewController {
    let modelLogic = MarvelCharactersModelLogic.shared
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Int,MarvelCellCharacter> = {
        UICollectionViewDiffableDataSource<Int,MarvelCellCharacter>(collectionView: collectionView) { [self] collectionView, indexPath, character in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                MarvelCharacterCellView(character: character)
            }
            
            
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        dataSource.apply(modelLogic.favoritesSnapshot,animatingDifferences: true)
        
        NotificationCenter.default.addObserver(forName: .marvelFavoritesChar, object: nil, queue: .main) { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
            self?.collectionView.reloadData()
            if let snapshot = self?.modelLogic.favoritesSnapshot {
                
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
   
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .marvelFavoritesChar, object: nil)
    }
    
}
