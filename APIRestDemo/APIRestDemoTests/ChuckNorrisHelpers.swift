//
//  ChuckNorrisHelpers.swift
//  APIRestDemoTests
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import Foundation
@testable import APIRestDemo

extension ChuckNorrisModel {
    static let samples = (0..<5).map { ChuckNorrisModel(categories: ["Category \($0)"], value: "Joke \($0)") }
    
    
    static let sample = ChuckNorrisModel(categories: ["Category 1"], value: "Joke1")
}

final class ChuckURLSessionMock: URLProtocol {
    
    let jokesData = try? JSONEncoder().encode(ChuckNorrisModel.samples)
    let jokeData  = try? JSONEncoder().encode(ChuckNorrisModel.sample)
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        
        if let url = request.url, url == .chuckNorrisURL, let jokeData {
            client?.urlProtocol(self, didLoad: jokeData)
            if let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type":"application/json"]) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
        } else {
            client?.urlProtocol(self, didFailWithError: PersistenceError.data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
        
    }
    override func stopLoading() { }
}

struct URLTesting: URLLocator {
    var chuckNorrisURL = URL(string: "http://localhost:8080/jokes/random")!
    
    var chuckNorrisFavorites: URL = Bundle(for: APIRestDemoTests.self).url(forResource: "testJokes", withExtension: "json")!
    
}
