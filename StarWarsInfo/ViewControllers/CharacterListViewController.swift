//
//  CharacterListViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 05/05/23.
//

import UIKit

final class CharacterListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLukeSkywalker()
        fetchCharacters()
        
//        fetchStarShips()
//        fetchPlanets()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        return cell
    }
}

extension CharacterListViewController {
    
    private func fetchCharacters() {
        URLSession.shared.dataTask(with: Link.characters.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(Characters.self, from: data)
                print(characters)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchLukeSkywalker() {
        URLSession.shared.dataTask(with: Person.lukeSkywalker.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let character = try decoder.decode(Character.self, from: data)
                print(character)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
//    private func fetchStarShips() {
//        URLSession.shared.dataTask(with: Link.starShips.url) { data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let ships = try decoder.decode(Ships.self, from: data)
//                print(ships)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
    
//    private func fetchPlanets() {
//        URLSession.shared.dataTask(with: Link.planets.url) { data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let planets = try decoder.decode(Planets.self, from: data)
//                print(planets)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
}
