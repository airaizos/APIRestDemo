//
//  MarvelResultsModel.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import UIKit

struct MarvelResults:Codable {

    let data: ResultData
    
    struct ResultData:Codable {
        let results: [MarvelCharacter]
        
       
    }
}

struct MarvelCharacter: Codable {
    let id: Int
    let name: String
    let thumbnailURL: ThumbnailURL
    
    enum CodingKeys: String, CodingKey {
        case id, name, thumbnailURL = "thumbnail"
        
    }
}

struct ThumbnailURL: Codable {
    let path: String
    let imageExtension: String
    
    enum CodingKeys:String, CodingKey {
        case path, imageExtension = "extension"
    }
}



struct MarvelCellCharacter:Identifiable {
    let uuid: UUID
    let id: Int
    let name: String
    let thumbnail: UIImage
    
}
