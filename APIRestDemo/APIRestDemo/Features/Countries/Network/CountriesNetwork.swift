//
//  CountriesNetwork.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 26/1/24.
//

import UIKit


final class CountriesNetwork {
    static let shared = CountriesNetwork()
   
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    ///Cambia func fetchJson con patron Callback a AsyncAwait
    private func getJSONAsync<JSON:Codable>(url: URL, type: JSON.Type) async throws -> JSON {
        try await withCheckedThrowingContinuation { continuation in
            fetchJson(url: url, type: type.self, session: session) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    ///Cambia la función fetchImage con patrón Callback a AsyncAwait
    private func getImageAsync(url: URL) async throws -> UIImage {
        try await withCheckedThrowingContinuation { continuation in
            fetchImage(url: url,session: session) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func getCountriesInfo(url: URL) async throws -> [CountryInfoModel] {
        let url = Bundle.main.url(forResource: "countries", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode([CountryInfoModel].self, from: data)
        
       //try await getJSONAsync(url: url, type: [CountryInfoModel].self)
    }
    
    func getFlagIcon(ccaCode:String) async throws -> UIImage {
        try await fetchImage(url: .flagIcon(for: ccaCode), session: session)
    }
    
    func getFlagImage(ccaCode:String) async throws -> UIImage {
        try await fetchImage(url: .flagImage(for: ccaCode), session: session)
    }
    
    // Detail
    func getRegions(ccaCode:String) async throws -> [BattutaRegionModel] {
        try await getJSONAsync(url: .regions(for: ccaCode), type: [BattutaRegionModel].self)
        
    }
    
    func getCities(ccaCode: String, region: String) async throws -> [BattutaCityModel] {
        try await getJSONAsync(url: .cities(for: ccaCode, region: region), type: [BattutaCityModel].self)
    }
}
