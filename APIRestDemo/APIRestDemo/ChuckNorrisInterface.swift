//
//  chuckNorrisInterface.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import Foundation

extension URL {
    static let chuckNorrisURL = URL(string: "https://api.chucknorris.io/jokes/random")!
    
    static let chuckNorrisFavorites = URL.documentsDirectory.appending(path: "chuckNorris.json")
}

protocol URLLocator {
    var chuckNorrisURL: URL { get }
    var chuckNorrisFavorites: URL { get }
}

struct URLProduction: URLLocator {
    let chuckNorrisURL = URL(string: "https://api.chucknorris.io/jokes/random")!
    let chuckNorrisFavorites = URL.documentsDirectory.appending(path: "chuckNorris.json")
}
