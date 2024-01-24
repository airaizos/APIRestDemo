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
    
    ///#Patrón Callback
   private func fetchJson<JSON:Codable>(url: URL, type: JSON.Type, callback: @escaping ((Result<JSON,PersistenceError>) -> Void)) {
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return callback(.failure(.general("error General")))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return callback(.failure(.status))
            }
            guard let data = data else {
                return callback(.failure(.data))
            }
            do {
                let result = try JSONDecoder().decode(JSON.self, from: data)
                callback(.success(result))
            } catch let error {
                callback(.failure(.json(error.localizedDescription)))
            }
            
        }.resume()
    }
    
    func getJoke(callback: @escaping ((Result<ChuckNorrisModel, PersistenceError>) -> Void)) {
        fetchJson(url: .chuckNorrisURL, type: ChuckNorrisModel.self, callback: callback)
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



