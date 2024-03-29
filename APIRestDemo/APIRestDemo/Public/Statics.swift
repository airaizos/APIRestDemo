//
//  Statics.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 26/1/24.
//

import UIKit

//MARK: Patrón Callback

///#Patrón Callback JSON Genérico
func fetchJson<JSON:Codable>(url: URL, type: JSON.Type, session: URLSession, callback: @escaping ((Result<JSON,PersistenceError>) -> Void)) {
     
     session.dataTask(with: url) { data, response, error in
         guard error == nil else {
             return callback(.failure(.general("error General")))
         }
         guard let response = response as? HTTPURLResponse, 
                response.statusCode == 200 else {
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

///#Patrón Callback Image
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

//MARK: Async-Await
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

func getJSONAsAw<JSON:Codable>(url:URL, type:JSON.Type) async throws -> JSON {
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else { throw PersistenceError.noHTTP }
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                throw PersistenceError.json(error.localizedDescription)
            }
        } else {
            throw PersistenceError.status
        }
    } catch let error as PersistenceError {
        throw error
    } catch {
        throw PersistenceError.general(error.localizedDescription)
    }
}

//MARK: Combine
///#Combine
///Ver **CommunesNetwork**
///Ver **NumbersPersistence**
