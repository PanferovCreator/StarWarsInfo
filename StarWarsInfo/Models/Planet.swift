//
//  Planet.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 05/05/23.
//

import Foundation

struct Planets: Decodable {
    let count: Int
    let results: [Planet]
}

struct Planet: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let surface_water: String
    let population: String
}
