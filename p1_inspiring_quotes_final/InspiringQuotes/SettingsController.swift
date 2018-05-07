//
//  SettingsController.swift
//  InspiringQuotes
//
//  Created by dev7 on 12/16/16.
//  Copyright © 2016 dev7lab. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    // MARK: *** UI Elements
    @IBOutlet weak var intervalTextField: UITextField!
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Thêm nút Done cho bàn phím
        addDoneButton(to: intervalTextField)
    }
    
    // MARK: *** UI Events
    @IBAction func backButton_Tapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Lưu lại thay đổi
    @IBAction func saveButton_Tapped(_ sender: UIButton) {
        if intervalTextField.isEmpty() {
            let title = "Error"
            let message = "Seconds text field cannot be empty!"
            alert(title: title, message:  message)
            
        } else {
            performSegue(withIdentifier: "SegueBackToMainID", sender: self)
        }
    }
    
    // Trước khi thực hiện segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueBackToMainID" {
            let dest = segue.destination as! ViewController
            
            // Truyền dữ liệu ngược lại màn hình đích
            dest.interval = Double(intervalTextField.text!)!
        }
    }
}
