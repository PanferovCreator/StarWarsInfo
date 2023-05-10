//
//  ShipListViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 08/05/23.
//

import UIKit

final class ShipListViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var ships: [Ship] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStarShips()
        tableView.rowHeight = 80
    }

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shipDetailsVC = segue.destination as? ShipDetailsViewController
        shipDetailsVC?.ship = sender as? Ship
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ships.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ship", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let ship = ships[indexPath.row]
        content.text = ship.name
        content.secondaryText = ship.manufacturer
        content.image = UIImage(named: ship.name)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        activityIndicator.stopAnimating()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ship = ships[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: ship)
    }
}

    // MARK: - Extensions

extension ShipListViewController {
    private func fetchStarShips() {
        for ship in Link.starShips.url {
            networkManager.fetch(Ships.self, from: ship) { [weak self] result in
                switch result {
                case .success(let ships):
                    self?.ships.append(contentsOf: ships.results)
                    self?.ships.sort { $0.name < $1.name}
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

