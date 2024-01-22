//
//  CommunesModeLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import SwiftUI


final class CommunesModeLogic {
    static let shared = CommunesModeLogic()
    
    let persistence: CommunesFetcher
    
    private var regions = [Region]() {
        didSet {
            NotificationCenter.default.post(name: .regions, object: nil)
        }
    }
    
    private var departements = [Departement]() {
        didSet {
            NotificationCenter.default.post(name: .regions, object: nil)
        }
    }
    private var communes = [Commune]() {
        didSet {
            NotificationCenter.default.post(name: .regions, object: nil)
        }
    }
    
    init(persistence: CommunesFetcher = CommunesPersistence.shared) {
        self.persistence = persistence
        
    }
    
    //MARK: Regions
    func getRegionsCount() -> Int {
        regions.count
    }
    
    func getRegionRow(indexPath: IndexPath) -> Region {
        regions[indexPath.row]
    }
    
    
    func fetchRegions() {
        persistence.getJSON(url: .regionsURL, type: [Region].self) { region in
            self.regions = region
        }
    }
    
    func deleteRegion(indexPath: IndexPath) {
        regions.remove(at: indexPath.row)
    }
    
    func moveRegion(indexPath from: IndexPath, to: IndexPath) {
        regions.swapAt(from.row, to.row)

    }
    
    //MARK: Department
    func fetchDepartementsFor(codeRegion: String) {
        persistence.getJSON(url: .selectedRegion(code: codeRegion), type: [Departement].self) { departements in
            self.departements = departements
        }
    }
    
    func getDepartementsCountFor(region: Region?) -> Int {
        departements.count
    }
    
    func getDepartementRow(indexPath: IndexPath) -> Departement {
        departements[indexPath.row]
    }
    
    func deleteDepartement(indexPath: IndexPath) {
        departements.remove(at: indexPath.row)
    }
    
    func moveDepartement(indexPath: IndexPath, to: IndexPath) {
        departements.swapAt(indexPath.row, to.row)
    }
    
    
    //MARK: Communes
    func fetchCommunesFor(codeDepartement: String) {
        persistence.getJSON(url: .selectedDepartement(code: codeDepartement), type: [Commune].self) { communes in
            self.communes = communes
        }
    }
    
    func getCommunesCountFor(departement: Departement?) -> Int {
            communes.count
    }
    
    func getCommuneRow(indexPath: IndexPath) -> Commune {
        communes[indexPath.row]
    }
    
    func deleteCommuneFor(indexPath: IndexPath) {
        communes.remove(at: indexPath.row)
    }
    
    func moveCommune(from: IndexPath, to: IndexPath) {
        communes.swapAt(from.row, to.row)
    }
    
}


protocol CommunesFetcher {
    var session: URLSession { get }
    func getJSON<JSON:Decodable>(url: URL, type: JSON.Type, receiveValue: @escaping (JSON) -> ())
    
}
