//
//  PlanetListViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 08/05/23.
//

import UIKit

final class PlanetListViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var planets: [Planet] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlanets()
        tableView.rowHeight = 80
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let planetDetailsVC = segue.destination as? PlanetDetailsViewController
        planetDetailsVC?.planet = sender as? Planet
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planet", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let planet = planets[indexPath.row]
        content.text = planet.name
        content.secondaryText = planet.climate
        content.image = UIImage(named: planet.name)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        activityIndicator.stopAnimating()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let planet = planets[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: planet)
    }
}

    // MARK: - Extensions

extension PlanetListViewController {
    private func fetchPlanets() {
        for planet in Link.planets.url {
            networkManager.fetch(Planets.self, from: planet) { [weak self] result in
                switch result {
                case .success(let planets):
                    self?.planets.append(contentsOf: planets.results)
                    self?.planets.sort { $0.name < $1.name }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
