//
//  Character.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 05/05/23.
//
import Foundation

struct Characters: Decodable {
    let count: Int
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let url: URL
}

enum Person {
    case lukeSkywalker
    case darthVader
    case obiWanKenobi
    
    var url: URL {
        switch self {
            
        case .lukeSkywalker:
            return URL(string: "https://swapi.dev/api/people/1/")!
        case .darthVader:
            return URL(string: "https://swapi.dev/api/people/4/")!
        case .obiWanKenobi:
            return URL(string: "https://swapi.dev/api/people/10/")!
        }
    }
}

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
