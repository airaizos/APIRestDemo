//
//  ChuckNorrisModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import Foundation

final class ChuckNorrisModelLogic {
    static let shared = ChuckNorrisModelLogic()
    
    let persistence: ChuckNorrisPersistence
    let network: ChuckNorrisNetwork
    
    init(persistence: ChuckNorrisPersistence = .shared, network: ChuckNorrisNetwork = .shared) {
        self.persistence = persistence
        self.network = network
    }
    
    var action: ((String) -> Void)?
    var tableAction: ((String) -> Void)?
    
    private var joke: ChuckNorrisModel?
    
    private var favorites = [ChuckNorrisModel]() {
        didSet {
            do {
                try persistence.saveFavorites(jokes: favorites)
                tableAction?("")
            } catch {
                print("Error")
            }
        }
    }
    
    func getJoke() {
        network.getJoke { result in
            switch result {
            case .success(let success):
                self.joke = success
                self.action?("")
            case .failure(_): print("show error")
            }
        }
    }
    
    func saveJoke() {
        if let favorite = joke,
           !favorites.contains(where: { $0.value == favorite.value })
        {
            favorites.insert(favorite, at: 0)
            tableAction?("")
        }
    }
    
    func getLabel() -> String {
        joke?.value ?? ""
    }
    
    func getCategories() -> String {
        joke?.categoriesView ?? "No category"
    }
 
    //MARK: TableView
    func loadFavorites() {
        do {
            favorites = try persistence.getFavorites()
        } catch {
            print("Mostrar error")
        }
    }
    
    func getRowsCount() -> Int {
        favorites.count
    }
    
    func getJokeRow(at indexPath: IndexPath) -> ChuckNorrisModel {
        favorites[indexPath.row]
    }
    
    func deleteJoke(at indexPath: IndexPath) {
        favorites.remove(at: indexPath.row)
    }
    
    func moveJoke(from: IndexPath, to: IndexPath) {
        favorites.swapAt(from.row, to.row)
    }
}
