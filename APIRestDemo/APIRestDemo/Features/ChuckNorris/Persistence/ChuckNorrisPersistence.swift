//
//  ChuckNorrisPersistence.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import Foundation


final class ChuckNorrisPersistence {
    static let shared = ChuckNorrisPersistence()
    var urls: URLLocator
    
    init(urls: URLLocator = URLProduction()) {
        self.urls = urls
    }
    
    //Save to Documents Directory
    func saveFavorites(jokes: [ChuckNorrisModel]) throws {
        let data = try JSONEncoder().encode(jokes)
        try data.write(to: urls.chuckNorrisFavorites, options: .atomic)
    }
    
    func getFavorites() throws -> [ChuckNorrisModel] {
        let data = try Data(contentsOf: urls.chuckNorrisFavorites)
        return try JSONDecoder().decode([ChuckNorrisModel].self, from: data)
    }
}



