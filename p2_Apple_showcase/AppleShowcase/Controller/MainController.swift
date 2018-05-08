//
//  MainController.swift
//  AppleShowcase
//
//  Created by dev7 on 1/6/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: *** Data model
    let categories = ["Macbook", "iPhone", "iPad"]
    let products = [
        ["Macbook 13", "Macbook 13 with Touchbar", "Macbook 15"],
        ["iPhone 6", "iPhone 6 Plus", "iPhone 7", "iPhone 7 Plus"],
        ["iPad Pro 9.7\"", "iPad Pro 12.9\""]
    ]
    
    let images = [
        ["Macbook13.jpg", "Macbook13Touchbar.jpg", "Macbook15.jpg"],
        ["iPhone6s.jpg", "iPhone6sPlus.jpg", "iPhone7.jpg", "iPhone7Plus.jpg"],
        ["iPadPro9.7.jpg", "iPadPro12.9.jpg"]
    ]
    
    let prices = [
        [35180000, 47180000, 62680000],
        [12650000, 15250000, 15750000, 19700000],
        [16580000, 17380000]
    ]
    
    var selectedIndex = -1
    
    // MARK: *** UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: *** UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[self.selectedIndex]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products[self.selectedIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellID") as! ProductCell
        
        let i = self.selectedIndex //indexPath.section
        let j = indexPath.row
        cell.productNameLabel.text = products[i][j]
        cell.priceLabel.text = "\(prices[i][j].toVnd())"
        cell.productImage.image = UIImage(named: images[i][j])
        
        return cell
    }
    
    var selectedSection = -1
    var selectedRow = -1
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSection = selectedIndex //indexPath.section
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "SegueShowDetailID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowDetailID" {
            let dest = segue.destination as! DetailController
            dest.name = products[selectedSection][selectedRow]
            dest.price = prices[selectedSection][selectedRow]
            dest.image = images[selectedSection][selectedRow]
        }
    }
}
