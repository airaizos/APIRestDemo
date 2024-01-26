//
//  CountryInfoModel.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 26/1/24.
//

import Foundation

struct CountryInfoModel: Codable {
    let name: String                    //France
    let tld: [String]                   //.fr
    let cca2: String                    //FR
    let cca3: String                    //FRA
    let independent: Bool?              //true
    let callingcode: String             //+33
    let capital: [String]               //[Paris]
    let languages: [String: String]     //[fra:French]
    let borders: [String]               //[AND,BEL...]
    let area: Double                    //551695
    let flag: String                    //"https://flagcdn.com/fr.svg"
    let coatOfArms: String              //"https://mainfacts.com/media/images/coats_of_arms/fr.svg"
    let population: Int                 //67391582
    let timezones: [String]             //[UTC-10:00,UTC-09:30... ]
}
