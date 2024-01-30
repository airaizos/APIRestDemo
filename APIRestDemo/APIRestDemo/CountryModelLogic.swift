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
    
    private var countries = [CountryInfoModel]()
    
    private var countryFlag = [String:UIImage]() {
        didSet {
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
    
    var countriesPendIcons = [CountryInfoModel]()
    
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
    

}
