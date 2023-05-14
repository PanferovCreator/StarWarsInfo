//
//  CharacterListViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 05/05/23.
//

import UIKit


final class CharacterListViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var swapi: Characters?
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
        let detailsVC = segue.destination as? CharacterDetailsViewController
        detailsVC?.character = sender as? Character
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swapi?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = swapi?.results else { return }
        if results.count - indexPath.row == 1 {
            getNextPage(from: nextPage)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let characters = Character.getCharacter(from: swapi?.results as Any)
        let character = characters[indexPath.row]
        content.text = character.name
        content.secondaryText = character.gender
        content.image = UIImage(named: character.name)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        activityIndicator.stopAnimating()
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characters = Character.getCharacter(from: swapi?.results as Any)
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: character)
    }
}

    // MARK: - Extensions

extension CharacterListViewController {

    private func fetchData() {
        networkManager.fetchData(from: Link.characters.url) { [weak self] result in
            switch result {
            case .success(let swapi):
                self?.swapi = swapi
                self?.nextPage = swapi.next
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getNextPage(from url: String?) {
        networkManager.fetchPage(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let swapi):
                self.swapi?.results.append(contentsOf: swapi.results)
                self.nextPage = swapi.next
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

