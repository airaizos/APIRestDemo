//
//  MarvelCharactersInterface.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import Foundation

extension URL {
    
    static func marvelCharacters(offset: Int) -> URL {
        let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public/characters?")!
        
        let offset = URLQueryItem(name: "offset", value: "\(offset)")
        let ts = URLQueryItem(name: "ts", value: mrvl.0)
        let ak = URLQueryItem(name: "apikey", value: mrvl.1)
        let hs = URLQueryItem(name: "hs", value: mrvl.2)
        
        return baseURL.appending(queryItems: [offset,ts,ak,hs])
    }
    
    static func characterThumbnail(_ thumbnail: ThumbnailURL) -> URL {
        URL(string: "\(thumbnail.path)\(thumbnail.imageExtension)") ?? URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!
    }
    
    static let MRVL = URL.documentsDirectory.appending(path: "MV.json")
}

var mrvl:(String,String,String) {
    if let data = try? Data(contentsOf: .MRVL),
       let keys = try? JSONDecoder().decode([MARVL].self, from: data),
       let first = keys.first(where: { $0.name == "MARVL"}) {
        return (first.ts, first.AK,first.HS)
    }
    return ("","","")
}

struct MARVL:Codable {
    let name: String
    let ts:String
    let AK:String
    let HS:String
}
