//
//  CollectionViewCell.swift
//  Homework54
//
//  Created by Kato on 7/2/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import ShimmerSwift

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myContentView: UIView!
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.myContentView.layer.shadowColor = UIColor.gray.cgColor
            self.myContentView.layer.shadowOpacity = 0.5
            self.myContentView.layer.shadowOffset = .zero
            self.myContentView.layer.shadowPath = UIBezierPath(rect: self.myContentView.bounds).cgPath
            self.myContentView.layer.shouldRasterize = true
        }
        
    }

}
