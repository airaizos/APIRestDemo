//
//  NumbersPersistence.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//

import Foundation
import Combine

final class NumbersPersistence {
    
    static let shared = NumbersPersistence()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    var subscribers = Set<AnyCancellable>()
    
    func getNumberOfTheDay(url: URL = .numbersURL, _ completion: @escaping (Number) -> ()) {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .sink { completed in
                switch completed {
                case .finished: break
                case .failure(let error): print("show \(error)")
                }
            } receiveValue: { data in
                let number = try! JSONDecoder().decode(Number.self, from: data)
                completion(number)
            }.store(in: &subscribers)
    }
}
