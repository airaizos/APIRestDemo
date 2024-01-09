//
//  Extensions.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String{
        prefix(1).uppercased() + dropFirst()
    }
}
extension Date {
    static let dateTest = "2024-02-12T19:00:00+0100".toDate()
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self) ?? Date.now
    }
}
