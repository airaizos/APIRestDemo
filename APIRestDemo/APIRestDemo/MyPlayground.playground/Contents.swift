import UIKit
import Combine

let commonURL = URL(string: "https://geo.api.gouv.fr/")!
let communeURL = commonURL.appending(path: "communes")
let regionsURL = commonURL.appending(path: "regions")
let departementsURL = commonURL.appending(path: "departements")


struct Region: Codable {
    let nom: String
    let code: String
}

struct Departement:Codable {
    let nom:String
    let code: String
    let codeRegion:String
}
struct Commune:Codable {
    let nom:String
    let code: String
    let codeDepartement: String
    let siren: String?
    let codeEpci: String?
    let codeRegion: String
    let codesPostaux: [String]
    let population: Int?
}

var subscribers = Set<AnyCancellable>()





enum PersistenceError: Error {
case status, noHTTP, server, json
}


//getJSON(url: regionsURL, type: [Region].self){ region in
//    print(region.first!)
//}

//getJSON(url: departementsURL, type: [Departement].self){ region in
//    print(region.first!)
//}

getJSON(url: communeURL, type: [Commune].self){ region in
    print(region.first!)
}

func getJSON2<JSON:Codable>(url:URL, type:JSON.Type) async throws -> JSON {
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else { throw PersistenceError.noHTTP }
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                throw PersistenceError.json
            }
        } else {
            throw PersistenceError.status
        }
    } catch let error as PersistenceError {
        throw error
    } catch {
        throw PersistenceError.server
    }
}

Task {
    do {
        let deptos = try await getJSON2(url: communeURL, type: [Commune].self)
        print(deptos.first!)
    } catch let error as PersistenceError {
        print("error")
    } catch {
        print("Error \(error)")
    }
}
