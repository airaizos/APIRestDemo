//
//  MarvelCharactersModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import Foundation

final class MarvelCharactersModelLogic {
    static let shared = MarvelCharactersModelLogic()
    
    let network: MarvelCharactersNetwork
    
    init(network: MarvelCharactersNetwork = .shared) {
        self.network = network
    }
    
    
    
}
