//
//  UIExtesion.swift
//  InspiringQuotes
//
//  Created by dev7 on 12/16/16.
//  Copyright © 2016 dev7lab. All rights reserved.
//

import UIKit

extension UIViewController {
    // Hiển thị thông báo đơn giản
    @objc func alert(title: String, message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Thêm nút Done để ẩn đi bàn phím
    @objc func addDoneButton(to control: UITextField){
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: control,
                            action: #selector(UITextField.resignFirstResponder))
        ]
        
        toolbar.sizeToFit()
        control.inputAccessoryView = toolbar
    }
}

extension UITextField {
    @objc func isEmpty() -> Bool {
        return self.text?.count == 0
    }
}
