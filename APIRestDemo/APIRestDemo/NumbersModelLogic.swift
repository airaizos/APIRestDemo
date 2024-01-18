//
//  NumbersModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//

import Foundation

final class NumbersModelLogic {
    static let shared = NumbersModelLogic()
    
    let persistence: NumbersPersistence
    
    init(persistence: NumbersPersistence = .shared) {
        self.persistence = persistence
    }

    var number: Number = .empty 
    
    func getNumber() {
        persistence.getNumberOfTheDay { num in
            self.number = num
            NotificationCenter.default.post(name: .number, object: self.number)
        }
    }
}

