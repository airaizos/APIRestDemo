//
//  CountryModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 30/1/24.
//

import UIKit

final class CountryModelLogic {
    static let shared = CountryModelLogic()
    
    let network: CountriesNetwork
    
    init(network: CountriesNetwork = .shared) {
        self.network = network
        Task {
            countries = await getCountriesInfo()
            NotificationCenter.default.post(name: .countries, object: nil)
        }
    }
    
    private var selectedCountry: CountryInfoModel?
    
    private var countries = [CountryInfoModel]()
    
    private var countryFlag = [String:UIImage]() {
        didSet {
            print("\(countryFlag.count) Count Icons")
            NotificationCenter.default.post(name: .flag, object: nil)
        }
    }
    
    func getCountriesInfo() async -> [CountryInfoModel] {
        do {
            return try await network.getCountriesInfo(url: .countries)
            
        } catch let error {
            print("Error en pantalla: \(error)")
            return []
            
        }
    }
    
    //MARK: TableView
    var countriesCount: Int {
        countries.count
    }
    
    func getCountryRow(at indexPath: IndexPath) -> CountryInfoModel {
        countries[indexPath.row]
    }
    
    
    func getCountryIcon(_ indexPath: IndexPath) -> UIImage {
        if let icon = countryFlag[countries[indexPath.row].name] {
            return icon
        } else {
            return UIImage(named: "clock")!
        }
    }
    
    func downloadCountryIcon(_ indexPath: IndexPath) async {
        if countryFlag[countries[indexPath.row].name] != nil {
            return
        } else {
            do {
                let ccaCode = countries[indexPath.row].cca2
                let icon = try await network.getFlagIcon(ccaCode: ccaCode)
                countryFlag[countries[indexPath.row].name] = icon
            } catch {
                print("Error en pantalla: \(error)")
             
            }
        }
    }
}
