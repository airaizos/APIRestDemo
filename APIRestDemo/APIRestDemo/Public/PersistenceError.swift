//
//  PersistenceError.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import Foundation

enum PersistenceError: Error {
    case status, noHTTP, server, json(String?), general(String), data
}
