//
//  CommunesTestsHelpers.swift
//  APIRestDemoTests
//
//  Created by Adrian Iraizos Mendoza on 22/1/24.
//

import Foundation
import Combine

@testable import APIRestDemo

final class CommunesNetworkMock: CommunesFetcher {
    var session: URLSession
    var subject: PassthroughSubject<String, Never>
    func valuesReceived() {
    }
    
    init(subject: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>(), session: URLSession = .shared) {
        self.subject = subject
        self.session = session
    }
    
    func getJSON<JSON>(url: URL, type: JSON.Type, receiveValue: @escaping (JSON) -> ()) where JSON : Decodable {
        switch url {
        case .regionsURL: receiveValue(Region.samples() as! JSON)
        case .departementsURL: receiveValue(Departement.samples() as! JSON)
        case .franceCommunes: receiveValue(Commune.samples()as! JSON)
        default: break
        }
    }
}



extension Region {
    static func samples() -> [Region] {
        (0..<5).map { Region(nom: "Region \($0)", code: "\($0)") }
    }
}

extension Departement {
    static func samples() -> [Departement] {
        (0..<5).map { Departement(nom: "Departement \($0)", code: "\($0)", codeRegion: "Region Test") }
    }
}

extension Commune {
    static func samples() ->  [Commune] {
        (0..<5).map { Commune(nom: "Nom \($0)", code: "Code\($0)\($0)", codeDepartement: "Departement", siren: "", codeEpci: "", codeRegion: "", codesPostaux: ["\($0)"], population: 50)}
    }
}






