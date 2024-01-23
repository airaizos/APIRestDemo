//
//  ChuckNorrisPersistence.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import Foundation

final class ChuckNorrisPersistence {
    static let shared = ChuckNorrisPersistence()
    
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    ///#Patrón Callback
    func fetchJoke<JSON:Codable>(url: URL, type: JSON.Type, callback: @escaping ((Result<JSON,PersistenceError>) -> Void)) {
        
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
    
    //Save to Documents Directory
    func saveFavorites(jokes: [ChuckNorrisModel]) throws {
        let data = try JSONEncoder().encode(jokes)
        try data.write(to: .chuckNorrisFavorites, options: .atomic)
    }
    
    
    func getFavorites() throws -> [ChuckNorrisModel] {
        print(URL.chuckNorrisFavorites.absoluteString)
        let data = try Data(contentsOf: URL.chuckNorrisFavorites)
        return try JSONDecoder().decode([ChuckNorrisModel].self, from: data)
    }
    
}
