//
//  FranceInterface.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import Foundation

extension URL{
    static let franceCommunes = URL(string: "https://geo.api.gouv.fr/")!
    
   static let regionsURL = franceCommunes.appending(path: "regions")
   static let departementsURL = franceCommunes.appending(path: "departements")
    
    static func selectedRegion(code: String) -> URL {
        regionsURL.appending(path: code).appending(path: "departements")
    }
    
    static func selectedDepartement(code: String) -> URL {
        departementsURL.appending(path: code).appending(path: "communes")
    }
}
