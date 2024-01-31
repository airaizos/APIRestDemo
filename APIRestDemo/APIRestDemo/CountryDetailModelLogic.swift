//
//  CountryDetailModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 30/1/24.
//

import Foundation


final class CountryDetailModelLogic {
    
//    let network: CountriesNetwork
//    let country: CountryInfoModel
//    
//    init(network: CountriesNetwork = .shared, country: CountryInfoModel?)  {
//        
//        guard let country else { fatalError() }
//        self.network = network
//        self.country = country
//        
//        Task { @MainActor in
//            regions = try await getRegionsForCountry(country)
//        }
//    }
//    
//    private var regions = [BattutaRegionModel]()
//    
//    private var cities = [BattutaCityModel]()
//    
//    var regionsCount:Int {
//        regions.count
//    }
//    
//    var citiesCount:Int {
//        cities.count
//    }
//    
//    func getRegionRow(at indexPath: IndexPath) -> BattutaRegionModel {
//        regions[indexPath.row]
//    }
//    
//    func getCityRow(at indexPath: IndexPath) -> BattutaCityModel {
//        cities[indexPath.row]
//    }
//    
//    func getRegionsForCountry(_ country: CountryInfoModel) async throws -> [BattutaRegionModel] {
//        try await network.getRegions(ccaCode: country.cca2)
//    }
//    
//    func getCitiesFor(ccaCode:String, region: String) async throws -> [BattutaCityModel] {
//        try await network.getCities(ccaCode: ccaCode, region: region)
//    }
}
