//
//  DiceBearPersistence.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import UIKit

final class DiceBearPersistence {
    static let shared = DiceBearPersistence()
    
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
    
    ///#Async-Await
    func dataRequest(from url: URL) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(from: url)
        } catch {
           throw PersistenceError.general("")
        }
            
    }
    
   
    func fetchImage(url: URL) async throws -> UIImage {
       let (data,response) = try await dataRequest(from: url)
        guard let response = response as? HTTPURLResponse else { throw PersistenceError.noHTTP }
        
        guard response.statusCode == 200 else { throw PersistenceError.status }

        if let image = UIImage(data: data) {
            return image
        } else {
            throw PersistenceError.data
        }
    }
    
    func getFunEmoji() async throws -> UIImage {
        try await fetchImage(url: DiceBearModel.funEmoji.url)
    }
    
    func getEmojiWithOptions(_ model: DiceBearModel) async throws -> UIImage {
        try await fetchImage(url: DiceBearModel(
            funEmojiWithBackgroundColor: model.backgroundColor,
            backgroundType: model.backgroundType,
            eyes: model.eyes,
            mouth: model.mouth).url)

    }
    
}

