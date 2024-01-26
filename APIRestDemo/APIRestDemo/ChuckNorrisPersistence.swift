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
    
    var urlProtocol: URLProtocol.Type?
    var session: URLSession {
        if let urlProtocol {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [urlProtocol]
            return URLSession(configuration: configuration)
        } else {
            return URLSession.shared
        }
    }
    init(urlProtocol: URLProtocol.Type? = nil, urls: URLLocator = URLProduction()) {
        self.urlProtocol = urlProtocol
        self.urls = urls
    }
    
    
    func getJoke(callback: @escaping ((Result<ChuckNorrisModel, PersistenceError>) -> Void)) {
        fetchJson(url: .chuckNorrisURL, type: ChuckNorrisModel.self, session: session, callback: callback)
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



