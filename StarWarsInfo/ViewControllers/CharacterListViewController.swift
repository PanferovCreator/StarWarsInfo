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
    
    private var persons: [Character] = []

    private let networkManager = NetworkManager.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
        tableView.rowHeight = 80
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as? CharacterDetailsViewController
        detailsVC?.character = sender as? Character
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let character = persons[indexPath.row]
        content.text = character.name
        content.secondaryText = character.gender
        content.image = UIImage(named: character.name)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        activityIndicator.stopAnimating()
  
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = persons[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: character)
    }
}

    // MARK: - Extensions

extension CharacterListViewController {
    private func fetchCharacters() {
        for character in Link.characters.url {
            networkManager.fetch(Characters.self, from: character) { [weak self] result in
                switch result {
                case .success(let characters):
                    self?.persons.append(contentsOf: characters.results)
                    self?.persons.sort { $0.name < $1.name }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
        
