//
//  NetworkManager.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 09/05/23.
//

import Foundation

    // MARK: - Enums

enum Link {
    case characters
    case starShips
    case planets
    
    var url: [URL] {
        switch self {
            
        case .characters:
            let allCharacters: [URL] = [
                URL(string: "https://swapi.dev/api/people/")!,
                URL(string: "https://swapi.dev/api/people/?page=2")!,
                URL(string: "https://swapi.dev/api/people/?page=3")!,
                URL(string: "https://swapi.dev/api/people/?page=4")!,
                URL(string: "https://swapi.dev/api/people/?page=5")!,
                URL(string: "https://swapi.dev/api/people/?page=6")!,
                URL(string: "https://swapi.dev/api/people/?page=7")!,
                URL(string: "https://swapi.dev/api/people/?page=8")!,
                URL(string: "https://swapi.dev/api/people/?page=9")!
            ]
            return allCharacters
        case .starShips:
            let allStarships: [URL] = [
                URL(string: "https://swapi.dev/api/starships/")!,
                URL(string: "https://swapi.dev/api/starships/?page=2")!,
                URL(string: "https://swapi.dev/api/starships/?page=3")!,
                URL(string: "https://swapi.dev/api/starships/?page=4")!
            ]
            return allStarships
        case .planets:
            let allPlanets: [URL] = [
                URL(string: "https://swapi.dev/api/planets/")!,
                URL(string: "https://swapi.dev/api/planets/?page=2")!,
                URL(string: "https://swapi.dev/api/planets/?page=3")!,
                URL(string: "https://swapi.dev/api/planets/?page=4")!,
                URL(string: "https://swapi.dev/api/planets/?page=5")!,
                URL(string: "https://swapi.dev/api/planets/?page=6")!
            ]
            return allPlanets
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Fetch Data
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}


