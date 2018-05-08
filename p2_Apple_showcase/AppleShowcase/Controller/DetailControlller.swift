//
//  DetailControlller.swift
//  AppleShowcase
//
//  Created by dev7 on 1/6/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    // MARK: *** Data model
    var image = ""
    var name = ""
    var price = 0
    
    // MARK: *** UI Elements
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: *** UI events
    
    
    // MARK: *** Local variables
    
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImage.image = UIImage(named: image)
        productNameLabel.text = name
        priceLabel.text = "\(price.toVnd())"
        
        // Thêm nút về lại màn hình chính
        let homeButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(gotoRoot))
        self.navigationItem.setRightBarButton(homeButton, animated: true)
    }
    
    func gotoRoot() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}

