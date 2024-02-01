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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvelCharacterCell", for: indexPath) as? MarvelCharacterCollectionViewCell else { return UICollectionViewCell() }
            cell.nameLabel.text = character.name
            Task {
                cell.thumbnail.image = await character.thumbnail.byPreparingForDisplay()
            }

            return cell
        }
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        collectionView.dataSource = dataSource
        
        dataSource.apply(modelLogic.snapshot,animatingDifferences: true)
        
        NotificationCenter.default.addObserver(forName: .marvelCharacters, object: nil, queue: .main) { [self] _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
            self.dataSource.apply(self.modelLogic.snapshot, animatingDifferences: true)
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        Task {
            await modelLogic.addCharacters()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .marvelCharacters, object: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }



    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension Notification.Name {
    static let marvelCharacters = Notification.Name("MRVLCHAR")
}
