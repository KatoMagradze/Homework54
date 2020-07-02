//
//  ViewController.swift
//  Homework54
//
//  Created by Kato on 7/2/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import ShimmerSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let apiservice = APIService()
    
    var allCharacters : AllCharacters?
    var charactersArray = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionview_cell")
        
        //https://github.com/ink-spot/UPCarouselFlowLayout
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 115, height: collectionView.frame.size.height/2.5)
        flowLayout.scrollDirection = .vertical
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        apiservice.fetchCharacters { (allCharacters) in
            
            for character in allCharacters.results {
                self.charactersArray.append(character)
            }
            
            //print(self.charactersArray)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

    }

}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionview_cell", for: indexPath) as! CollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.myLabel.text = charactersArray[indexPath.row].name
        
        charactersArray[indexPath.row].image.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.myImageView.image = image
            }
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "details_vc")
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        if let vc = detailsVC as? DetailsViewController {
            vc.name = charactersArray[indexPath.row].name
            vc.myImage = cell.myImageView.image!

        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension String {
    
    func downloadImage(completion: @escaping (UIImage?) -> ()) {

        guard let url = URL(string: self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
    
}

