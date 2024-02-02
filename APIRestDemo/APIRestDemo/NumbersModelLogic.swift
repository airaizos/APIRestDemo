//
//  NumbersModelLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//

import Foundation

final class NumbersModelLogic {
    static let shared = NumbersModelLogic()
    
    let network: NumbersNetwork
    
    init(network: NumbersNetwork = .shared) {
        self.network = network
    }

    var number: Number = .empty 
    
    func getNumber() {
        network.getNumberOfTheDay { num in
            self.number = num
            NotificationCenter.default.post(name: .number, object: self.number)
        }
    }
}

