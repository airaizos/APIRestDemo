//
//  CommuneModel.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import Foundation

struct Commune:Codable,Hashable {
    let nom:String
    let code: String
    let codeDepartement: String
    let siren: String?
    let codeEpci: String?
    let codeRegion: String?
    let codesPostaux: [String]
    let population: Int?
}

struct Region: Codable {
    let nom: String
    let code: String
}

struct Departement:Codable {
    let nom:String
    let code: String
    let codeRegion:String
}


extension Commune: Equatable {
   static func ==(lhs: Commune, rhs: Commune) -> Bool {
       lhs.code == rhs.code
    }
}

extension Commune {
    var populationText:String {
        population.map { "\($0)" } ?? "N/A"
    }
    
}
