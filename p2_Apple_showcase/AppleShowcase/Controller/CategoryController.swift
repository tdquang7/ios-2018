 //
//  CategoryController.swift
//  AppleShowcase
//
//  Created by dev on 1/6/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import UIKit

class CategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: *** Data models
    let images = ["Macbook13.jpg", "iPhone6s.jpg", "iPadPro9.7.jpg"]
    let names = ["Macbook", "iPhone", "iPad"]
    
    // MARK: *** Local variables
    
    // MARK: *** UI Elements
    
    // MARK: *** UI Events
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: *** UICollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellID", for: indexPath) as! CategoryCell
        cell.categoryImageView.image = UIImage(named: images[indexPath.row])
        cell.categoryNameLabel.text = names[indexPath.row]
        return cell
    }
    
    var selectedIndex = -1
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "SegueShowProductListID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowProductListID" {
            let dest = segue.destination as! MainController
            dest.selectedIndex = self.selectedIndex
        }
    }
}
