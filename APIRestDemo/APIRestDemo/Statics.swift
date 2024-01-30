//
//  Statics.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 26/1/24.
//

import UIKit

///#Patrón Callback
func fetchJson<JSON:Codable>(url: URL, type: JSON.Type, session: URLSession, callback: @escaping ((Result<JSON,PersistenceError>) -> Void)) {
     
     session.dataTask(with: url) { data, response, error in
         guard error == nil else {
             return callback(.failure(.general("error General")))
         }
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             return callback(.failure(.status))
         }
         guard let data = data else {
             return callback(.failure(.data))
         }
         do {
             let result = try JSONDecoder().decode(JSON.self, from: data)
             callback(.success(result))
         } catch let error {
             callback(.failure(.json(error.localizedDescription)))
         }
         
     }.resume()
 }

func fetchImage(url:URL, session: URLSession, callback: @escaping ((Result<UIImage,PersistenceError>) -> Void)) {
    session.dataTask(with: url) { data, response, error in
        guard let data, let res = response as? HTTPURLResponse else {
            if let error {
                return callback(.failure(.general("error General \(error)")))
            }
            return
        }
        if res.statusCode == 200 {
            if let imagen = UIImage(data: data) {
                callback(.success(imagen))
            }
        } else {
            callback(.failure(.status))
        }
    }.resume()
}


///#Async-Await
func dataRequest(from url: URL, session: URLSession) async throws -> (Data, URLResponse) {
    do {
        return try await session.data(from: url)
    } catch {
       throw PersistenceError.general("")
    }
        
}


func fetchImage(url: URL, session: URLSession) async throws -> UIImage {
   let (data,response) = try await dataRequest(from: url,session: session)
    guard let response = response as? HTTPURLResponse else { throw PersistenceError.noHTTP }
    
    guard response.statusCode == 200 else { throw PersistenceError.status }

    if let image = UIImage(data: data) {
        return image
    } else {
        throw PersistenceError.data
    }
}
