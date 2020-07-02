//
//  DetailsViewController.swift
//  Homework54
//
//  Created by Kato on 7/2/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var myImage = UIImage()
    var name = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNameLabel.text = self.name
        characterImage.image = myImage
        // Do any additional setup after loading the view.
    }
    

}
