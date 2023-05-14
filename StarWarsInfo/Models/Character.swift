//
//  Character.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 05/05/23.
//
import Foundation

struct Characters {
    let count: Int
    let next: String?
    let pervious: String?
    var results: [[String : Any]]
    
    init(count: Int, next: String?, pervious: String?, results: [[String : Any]]) {
        self.count = count
        self.next = next
        self.pervious = pervious
        self.results = results
    }
    
    init(from charactersData: [String: Any]) {
        count = charactersData["count"] as? Int ?? 0
        next = charactersData["next"] as? String
        pervious = charactersData["pervious"] as? String
        results = charactersData["results"] as? [[String: Any]] ?? []
    }
    
    static func getCharacters(from value: Any) -> Characters {
        guard let charactersData = value as? [String: Any] else { return Characters(from: [:]) }
        return Characters(from: charactersData)
    }
}

struct Character {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let starships: [String]
    let url: String
    
    var description: String {
        """
        gender: \(gender)
        height: \(height)
        mass: \(mass)
        hair color: \(hairColor)
        skin color: \(skinColor)
        eye color: \(eyeColor)
        birth year: \(birthYear)
        """
    }
    
    init(
        name: String, height: String, mass: String,
        hairColor: String, skinColor: String, eyeColor: String,
        birthYear: String, gender: String, homeworld: String,
        starships: [String], url: String
    ) {
        self.name = name
        self.height = height
        self.mass = mass
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.eyeColor = eyeColor
        self.birthYear = birthYear
        self.gender = gender
        self.homeworld = homeworld
        self.starships = starships
        self.url = url
    }
    
    init(from characterData: [String: Any]) {
        name = characterData["name"] as? String ?? ""
        height = characterData["height"] as? String ?? ""
        mass = characterData["mass"] as? String ?? ""
        hairColor = characterData["hair_color"] as? String ?? ""
        skinColor = characterData["skin_color"] as? String ?? ""
        eyeColor = characterData["eye_color"] as? String ?? ""
        birthYear = characterData["birth_year"] as? String ?? ""
        gender = characterData["gender"] as? String ?? ""
        homeworld = characterData["homeworld"] as? String ?? ""
        starships = characterData["starships"] as? [String] ?? [""]
        url = characterData["url"] as? String ?? ""
    }
    
    static func getCharacter(from value: Any) -> [Character] {
        guard let characterData = value as? [[String: Any]] else { return [] }
        return characterData.map { Character(from: $0) }
    }
}

struct Ships {
    let count: Int
    let next: String?
    let pervious: String?
    var results: [[String : Any]]
    
    init(count: Int, next: String?, pervious: String?, results: [[String : Any]]) {
        self.count = count
        self.next = next
        self.pervious = pervious
        self.results = results
    }
    
    init(from shipsData: [String: Any]) {
        count = shipsData["count"] as? Int ?? 0
        next = shipsData["next"] as? String ?? ""
        pervious = shipsData["pervious"] as? String ?? ""
        results = shipsData["results"] as? [[String: Any]] ?? []
    }
    
    static func getShips(from value: Any) -> Ships {
        guard let shipsData = value as? [String: Any] else { return Ships(from: [:]) }
        return Ships(from: shipsData)
    }
}

struct Ship: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let hyperdriveRating: String
    let starshipClass: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let url: String
    
    var description: String {
        """
        name: \(name)
        model: \(model)
        manufacturer: \(manufacturer)
        cost in credits: \(costInCredits)
        length: \(length)
        max atmosphering speed: \(maxAtmospheringSpeed)
        hyper dive rating: \(hyperdriveRating)
        starship class: \(starshipClass)
        crew: \(crew)
        passengers: \(passengers)
        cargo capacity: \(cargoCapacity)
        """
    }
    
    init(
        name: String, model: String, manufacturer: String,
        costInCredits: String, length: String, maxAtmospheringSpeed: String,
        hyperdriveRating: String, starshipClass: String, crew: String,
        passengers: String, cargoCapacity: String, url: String
    ) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.costInCredits = costInCredits
        self.length = length
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.hyperdriveRating = hyperdriveRating
        self.starshipClass = starshipClass
        self.crew = crew
        self.passengers = passengers
        self.cargoCapacity = cargoCapacity
        self.url = url
    }
    
    init(from shipData: [String: Any]) {
        name = shipData["name"] as? String ?? ""
        model = shipData["model"] as? String ?? ""
        manufacturer = shipData["manufacturer"] as? String ?? ""
        costInCredits = shipData["cost_in_credits"] as? String ?? ""
        length = shipData["length"] as? String ?? ""
        maxAtmospheringSpeed = shipData["max_atmosphering_speed"] as? String ?? ""
        hyperdriveRating = shipData["hyperdrive_rating"] as? String ?? ""
        starshipClass = shipData["starship_class"] as? String ?? ""
        crew = shipData["crew"] as? String ?? ""
        passengers = shipData["passengers"] as? String ?? ""
        cargoCapacity = shipData["cargo_capacity"] as? String ?? ""
        url = shipData["url"] as? String ?? ""
    }
    
    static func getShip(from value: Any) -> [Ship] {
        guard let shipData = value as? [[String: Any]] else { return [] }
        return shipData.map { Ship(from: $0) }
    }
}

struct Planets {
    let count: Int
    let next: String?
    let pervious: String?
    var results: [[String : Any]]
    
    init(count: Int, next: String?, pervious: String?, results: [[String : Any]]) {
        self.count = count
        self.next = next
        self.pervious = pervious
        self.results = results
    }
    
    init(from planetsData: [String: Any]) {
        count = planetsData["count"] as? Int ?? 0
        next = planetsData["next"] as? String ?? ""
        pervious = planetsData["pervious"] as? String ?? ""
        results = planetsData["results"] as? [[String: Any]] ?? []
    }
    
    static func getPlanets(from value: Any) -> Planets {
        guard let planetsData = value as? [String: Any] else { return Planets(from: [:]) }
        return Planets(from: planetsData)
    }
}

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let surfaceWater: String
    let population: String
    let url: String
    
    var description: String {
        """
        name: \(name)
        rotation period: \(rotationPeriod)
        orbital period: \(orbitalPeriod)
        diameter: \(diameter)
        climate: \(climate)
        gravity: \(gravity)
        surface water: \(surfaceWater)
        population: \(population)
        """
    }
    
    init(
        name: String, rotationPeriod: String, orbitalPeriod: String,
        diameter: String, climate: String, gravity: String,
        surfaceWater: String, population: String, url: String
    ) {
        self.name = name
        self.rotationPeriod = rotationPeriod
        self.orbitalPeriod = orbitalPeriod
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.surfaceWater = surfaceWater
        self.population = population
        self.url = url
    }
    
    init(from planetData: [String: Any]) {
        name = planetData["name"] as? String ?? ""
        rotationPeriod = planetData["rotation_period"] as? String ?? ""
        orbitalPeriod = planetData["orbital_period"] as? String ?? ""
        diameter = planetData["diameter"] as? String ?? ""
        climate = planetData["climate"] as? String ?? ""
        gravity = planetData["graviti"] as? String ?? ""
        surfaceWater = planetData["surface_water"] as? String ?? ""
        population = planetData["population"] as? String ?? ""
        url = planetData["url"] as? String ?? ""
    }
    
    static func getPlanet(from value: Any) -> [Planet] {
        guard let planetData = value as? [[String: Any]] else { return [] }
        return planetData.map { Planet(from: $0) }
    }
}



