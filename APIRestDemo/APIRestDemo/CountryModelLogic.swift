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
        Task{
            countries = await getCountriesInfo()
            NotificationCenter.default.post(name: .countries, object: nil)
        }
    }
    
    private var countries = [CountryInfoModel]()
    private var regions = [BattutaRegionModel]() {
        didSet {
            NotificationCenter.default.post(name: .regions, object: nil)
        }
    }
    private var cities = [BattutaCityModel]() {
        didSet {
            NotificationCenter.default.post(name: .cities, object: nil)
        }
    }
    private var countryFlag = [String:UIImage]() {
        didSet {
            NotificationCenter.default.post(name: .flag, object: nil)
        }
    }
    
    private var selectedCountry: CountryInfoModel? {
        didSet  {
            NotificationCenter.default.post(name: .selectedCountry, object: selectedCountry)
        }
    }
    private var selectedFlag: UIImage? {
        didSet {
            NotificationCenter.default.post(name: .selectedFlag, object: selectedFlag)
        }
    }
    
    
  
    
    //MARK: Countries
    func getCountriesInfo() async -> [CountryInfoModel] {
        do {
            return try await network.getCountriesInfo(url: .countries)
        } catch let error {
            print("Error en pantalla: \(error)")
            return []
        }
    }
    
    func countryNameDict() {
        countries.forEach { countryFlag[$0.name] = nil }
    }
    
    func getFlag(at indexPath: IndexPath) async {
        let cca2 = countries[indexPath.row].cca2
        do {
            selectedFlag = try await network.getFlagImage(ccaCode: cca2)
        } catch {
            
        }
    }
    
    func didSelectCountry(at indexPath: IndexPath) {
        selectedCountry = countries[indexPath.row]
        Task {
            if let country = selectedCountry {
                selectedFlag = try await network.getFlagImage(ccaCode: country.cca2)
            }
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
        let country = countries[indexPath.row]
        let countryName = country.name
        if let icon = countryFlag[countryName] {
            return icon
        } else {
            Task { @MainActor in
                let icon = await downloadIcon(for: country)
                countryFlag[countryName] = icon
            }
            return UIImage(named: "clock")!
        }
    }
    
    func downloadIcon(for country: CountryInfoModel) async -> UIImage {
        do {
            return try await network.getFlagIcon(ccaCode: country.cca2)
        } catch {
            print("Error en pantalla: \(error)")
            return UIImage(named: "clock")!
        }
    }
    
    func rowSelected(at indexPath: IndexPath) {
        selectedCountry = countries[indexPath.row]
    }
    
    //MARK: Detail
    
    func getSelectedCountry() -> CountryInfoModel? {
        selectedCountry
    }
    func getSelectedCountryFlag() -> UIImage? {
        selectedFlag
    }
    
    func getRegionsCount() -> Int {
         regions.count
     }
     
     func getCitiesCount() -> Int {
         cities.count
     }
    
    func getRegionRow(at indexPath: IndexPath) -> BattutaRegionModel {
        regions[indexPath.row]
    }
    
    func getCityRow(at indexPath: IndexPath) -> BattutaCityModel {
        cities[indexPath.row]
    }
    
    func getRegionsForCountry(_ country: CountryInfoModel?) async  {
        guard let country else { return }
        do {
            self.regions = try await network.getRegions(ccaCode: country.cca2)
        } catch {
          return
        }
    }
    
    func getCitiesFor(ccaCode:String, region: String) async throws -> [BattutaCityModel] {
        try await network.getCities(ccaCode: ccaCode, region: region)
    }
    
    func didSelectRegion(at indexPath: IndexPath) {
        guard let country = selectedCountry else { return }
        Task {
            do {
                let region = regions[indexPath.row].region
                cities = try await getCitiesFor(ccaCode: country.cca2, region: region)
            } catch {
                print("Error pantalla")
            }
        }
    }
    
    func didSelectCity(at indexPath: IndexPath) {
       let city = cities[indexPath.row]
        //mostrar con las coordenadas en el mapa
    }
}
