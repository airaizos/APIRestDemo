//
//  CommunesPersistence.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import Foundation
import Combine


final class CommunesPersistence {
    static let shared = CommunesPersistence()
							
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    var subscribers = Set<AnyCancellable>()
    
    func getJSON<JSON:Decodable>(url: URL, type: JSON.Type, receiveValue: @escaping (JSON) -> ()) {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .mapError { _ in PersistenceError.noHTTP }
            .tryMap { (data,response) -> (Data,HTTPURLResponse) in
                guard let response = response as? HTTPURLResponse else {
                    throw PersistenceError.noHTTP
                }
                return (data,response)
            }
            .tryMap { (data,response) -> Data in
                switch response.statusCode {
                case 200..<300: return data
                case 500...: throw PersistenceError.server
                default: throw PersistenceError.status
                }
            }
            .decode(type: JSON.self, decoder: JSONDecoder())
            .mapError { error -> PersistenceError in
                if let error = error as? PersistenceError {
                    return error
                } else {
                    return PersistenceError.json
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print(url.absoluteString)
                case .failure(_): print("Error")
                }
            }, receiveValue: receiveValue)
            .store(in: &subscribers)
    }
    
   
}
