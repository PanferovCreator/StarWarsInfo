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
    
    private var swapiShips: Ships?
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
        let shipDetailsVC = segue.destination as? ShipDetailsViewController
        shipDetailsVC?.ship = sender as? Ship
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swapiShips?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ship", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let ships = Ship.getShip(from: swapiShips?.results as Any)
        let ship = ships[indexPath.row]
        content.text = ship.name
        content.secondaryText = ship.manufacturer
        content.image = UIImage(named: ship.name)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        activityIndicator.stopAnimating()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = swapiShips?.results else { return }
        if results.count - indexPath.row == 1 {
            getNextPage(from: nextPage)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ships = Ship.getShip(from: swapiShips?.results as Any)
        let ship = ships[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: ship)
    }
}

    // MARK: - Extensions

extension ShipListViewController {
    
    private func fetchData() {
        networkManager.fetchDataShips(from: Link.starShips.url) { [weak self] result in
            switch result {
            case .success(let swapiShips):
                self?.swapiShips = swapiShips
                self?.nextPage = swapiShips.next
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getNextPage(from url: String?) {
        networkManager.fetchPageShips(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let swapiShip):
                self.swapiShips?.results.append(contentsOf: swapiShip.results)
                self.nextPage = swapiShip.next
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

