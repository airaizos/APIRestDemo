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
    
    init(persistence: ChuckNorrisPersistence = .shared) {
        self.persistence = persistence
    }
    
    var action: ((String) -> Void)?
    private var joke: ChuckNorrisModel?
    
    var favorites = [ChuckNorrisModel]()
    
    func getJoke() {
        persistence.fetchJoke(url: .chuckNorrisURL, type: ChuckNorrisModel.self) { result in
            switch result {
            case .success(let success):
                self.joke = success
                self.action?("")
            case .failure(_): print("show error")
            }
        }
    }
    
    func saveJoke() {
        
    }
    
    func getLabel() -> String {
        joke?.value ?? ""
    }
    
    func getCategories() -> String {
        joke?.categories.joined(separator: ",") ?? "No category"
    }
    
}
