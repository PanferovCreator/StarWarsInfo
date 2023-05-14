//
//  NetworkManager.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 09/05/23.
//

import Foundation
import Alamofire

    // MARK: - Enums

enum Link {
    case characters
    case starShips
    case planets
    
    var url: URL {
        switch self {
            
        case .characters:
            return URL(string: "https://swapi.dev/api/people/")!
        case .starShips:
            return URL(string: "https://swapi.dev/api/starships/")!
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/")!
        }
    }
}

final class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Fetch Data
    
    func fetchData(from url: URL, completion: @escaping(Result<Characters, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let pageData):
                    let data = Characters.getCharacters(from: pageData)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchPage(from url: String?, completion: @escaping(Result<Characters, AFError>) -> Void) {
        guard let stringURL = url, let url = URL(string: stringURL) else {
            return
        }
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let pageData):
                    let page = Characters.getCharacters(from: pageData)
                    completion(.success(page))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchDataShips(from url: URL, completion: @escaping(Result<Ships, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let pageData):
                    let data = Ships.getShips(from: pageData)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchPageShips(from url: String?, completion: @escaping(Result<Ships, AFError>) -> Void) {
        guard let stringURL = url, let url = URL(string: stringURL) else {
            return
        }
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let pageData):
                    let page = Ships.getShips(from: pageData)
                    completion(.success(page))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchPlanetsData(from url: URL, completion: @escaping(Result<Planets, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let pageData):
                    let data = Planets.getPlanets(from: pageData)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchPagePlanets(from url: String?, completion: @escaping(Result<Planets, AFError>) -> Void) {
        guard let stringURL = url, let url = URL(string: stringURL) else {
            return
        }
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let pageData):
                    let page = Planets.getPlanets(from: pageData)
                    completion(.success(page))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
