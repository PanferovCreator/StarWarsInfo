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
    
    private var swapiPlanets: Planets?
    private var nextPage: String?
    private let networkManager = NetworkManager.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.rowHeight = 80
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let planetDetailsVC = segue.destination as? PlanetDetailsViewController
        planetDetailsVC?.planet = sender as? Planet
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swapiPlanets?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planet", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let planets = Planet.getPlanet(from: swapiPlanets?.results as Any)
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
        let planets = Planet.getPlanet(from: swapiPlanets?.results as Any)
        let planet = planets[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: planet)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = swapiPlanets?.results else { return }
        if results.count - indexPath.row == 1 {
            getNextPage(from: nextPage)
        }
    }
}

    // MARK: - Extensions

extension PlanetListViewController {
    
    private func fetchData() {
        networkManager.fetchPlanetsData(from: Link.planets.url) { [weak self] result in
            switch result {
            case .success(let swapiPlanets):
                self?.swapiPlanets = swapiPlanets
                self?.nextPage = swapiPlanets.next
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getNextPage(from url: String?) {
        networkManager.fetchPagePlanets(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let swapiPlanet):
                self.swapiPlanets?.results.append(contentsOf: swapiPlanet.results)
                self.nextPage = swapiPlanet.next
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
