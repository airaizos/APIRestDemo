//
//  CountryDetailViewLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 30/1/24.
//

import UIKit

final class CountryDetailViewLogic {
        static let shared = CountryDetailViewLogic()
    
        let modelLogic: CountryModelLogic
    
        init(modelLogic: CountryModelLogic = .shared) {
            self.modelLogic = modelLogic
        }
    
        func getCellForRegion(at indexPath: IndexPath) -> (identifier:String, name:String) {
            let region  = modelLogic.getRegionRow(at: indexPath)
            return ("countryRegionCell",region.region)
        }
    
        func getCellForCity(at indexPath: IndexPath) -> (identifier: String, name:String) {
            let city = modelLogic.getCityRow(at: indexPath)
            return ("cityCell", city.city)
        }
}
