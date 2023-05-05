//
//  Ship.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 05/05/23.
//

import Foundation

struct Ships: Decodable {
    let count: Int
    let results: [Ship]
}

struct Ship: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let cost_in_credits: String
    let length: String
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let cargo_capacity: String
}
