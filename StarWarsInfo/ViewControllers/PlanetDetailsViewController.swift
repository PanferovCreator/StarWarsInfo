//
//  PlanetDetailsViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 08/05/23.
//

import UIKit
import SpringAnimation

final class PlanetDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetDetailLabel: UILabel!
    @IBOutlet weak var planetDetailsView: SpringView!
    
    var planet: Planet!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetImageView.image = UIImage(named: planet.name)
        navigationItem.title = planet.name
        
        planetDetailsView.animate()
        planetDetailsView.setDescriptionBorder()
        
        planetDetailLabel.text = planet.description
    }
}
