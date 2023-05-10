//
//  ShipDetailsViewController.swift
//  StarWarsInfo
//
//  Created by Dmitriy Panferov on 08/05/23.
//

import UIKit
import SpringAnimation


final class ShipDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var shipImageView: UIImageView!
    @IBOutlet weak var shipDetailLabel: UILabel!
    @IBOutlet weak var shipDetailView: SpringView!

    var ship: Ship!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shipImageView.image = UIImage(named: ship.name)
        navigationItem.title = ship.name
        
        shipDetailView.animate()
        shipDetailView.setDescriptionBorder()

        shipDetailLabel.text = ship.description
    }
}
