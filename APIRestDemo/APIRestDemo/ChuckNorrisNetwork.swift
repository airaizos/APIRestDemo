//
//  ChuckNorrisNetwork.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 2/2/24.
//

import Foundation

final class ChuckNorrisNetwork {
    static let shared = ChuckNorrisNetwork()
    
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
    }
    
    
    func getJoke(callback: @escaping ((Result<ChuckNorrisModel, PersistenceError>) -> Void)) {
        fetchJson(url: .chuckNorrisURL, type: ChuckNorrisModel.self, session: session, callback: callback)
    }
}
