//
//  CountriesInterface.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 26/1/24.
//

import Foundation

extension URL {
    
    //All Countries
    static let countries = URL(string: "https://countryinfoapi.com/api/countries")!
    
    //ICONS
    static func flagIcon(for ccaCode:String) -> URL {
        URL(string:"https://flagsapi.com/\(ccaCode.uppercased())/flat/64.png")!
    }
    
    //FLAG 128x96
    static func flagImage(for ccaCode: String) -> URL {
        URL(string:"https://flagcdn.com/128x96/\(ccaCode.lowercased()).png")!
    }
    
    static func detailInfo(for cca3Code: String) -> URL {
        URL(string:"https://countryinfoapi.com/api/countries/\(cca3Code.uppercased())")!
    }
    
    //Regions
    static func regions(for ccaCode: String) -> URL {
    URL(string: "http://battuta.medunes.net/api/region/\(ccaCode)/all/?key=\(BATAK)")!
    }
    
    static func cities(for ccaCode: String, region: String) -> URL {
        //Validar que haya 3 letras mínimo
        let components = region.components(separatedBy: " ")
        let first = components.first?.prefix(3) 
        let last = components.last?.prefix(3)
        
        let code = last ?? first ?? region.prefix(3)
        let hint = code.count < 3  ? "123" : code //"123" == No region hint
        
        return URL(string: "http://battuta.medunes.net/api/city/\(ccaCode.lowercased())/search/?region=\(hint)&key=\(BATAK)")!
    }
    
    static let TK = URL.documentsDirectory.appending(path: "TK.json")
}


struct TK: Codable {
    let name: String
    let value: String
}

var BATAK: String {
    if let data = try? Data(contentsOf: .TK),
       let keys = try? JSONDecoder().decode([TK].self, from: data),
       let value = keys.first(where: { $0.name == "BATTK" } )?.value {
        return value
    } else {
        return ""
    }
}

extension Notification.Name {
    static let countries = Notification.Name("COUNTRIES")
    static let flag = Notification.Name("FLAG")
    static let selectedCountry = Notification.Name("COUNTRY")
    static let selectedFlag = Notification.Name("FLAG")
    static let regions = Notification.Name("REGIONS")
    static let cities = Notification.Name("CITIES")
}
