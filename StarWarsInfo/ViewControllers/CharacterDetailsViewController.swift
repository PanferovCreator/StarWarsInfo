//
//  CharacterDetailsViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 06/05/23.
//

import UIKit
import SpringAnimation

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterDetailLabel: UILabel!
    @IBOutlet weak var characterDetailView: SpringView!
    @IBOutlet weak var homeworldView: SpringView!
    @IBOutlet weak var homeworldLabel: UILabel!
    
    var character: Character!
 
    private let networkManager = NetworkManager.shared

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterImageView.image = UIImage(named: character.name)
        navigationItem.title = character.name
        
        characterDetailView.setDescriptionBorder()
        homeworldView.setAdditionalBorder()

        characterDetailView.animate()
        homeworldView.animate()

        characterDetailLabel.text = character.description
    }
}

    // MARK: - Extensions

extension SpringView {
    func setDescriptionBorder() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.yellow.cgColor
        self.layer.cornerRadius = 20
    }
    
    func setAdditionalBorder() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.systemMint.cgColor
        self.layer.cornerRadius = 15
    }
}


