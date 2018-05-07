//
//  ViewController.swift
//  InspiringQuotes
//
//  Created by dev on 12/13/16.
//  Copyright © 2016 dev7lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: *** Data models
    let quoteNames = ["quote01.png", "quote02.png", "quote03.png",
                      "quote04.png","quote05.png", "quote06.png",
                      "quote07.png", "quote08.png"]
    let quotes = [
        "A great pleasure in life is doing what people say you cannot do.",
        "Happiness is found when you stop comparing yourself to other people",
        "Your mind is a powerfull things. When you fill it with positive thoughts, your life will start to change",
        "If plan A didn't work, the alphabet has 25 more letters. Stay cool.",
        "If you don't go after what you want, you'll never have it. If you don't ask, the answer is always no. If you don't step forward, you're always in the same place",
        "When it is obvious that the goals cannot be reached, don't adjust the goals, adjust the action steps.",
        "If you are always trying to be NORMAL, you will never know how AMAZING you can be.",
        "There is no elevator to success. You have to take the stairs."
    ]
    
    var interval = 5.0 // s
    
    // MARK: *** UI Elements
    @IBOutlet weak var quoteImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    // MARK: *** Local variables
    var lastIndex = -1
    var timer = Timer()
    
    
    // MARK: *** UI Events
    @IBAction func nextButton_Tapped(_ sender: UIButton) {
        showRandomQuote()
    }
    
    // Sinh chỉ mục ngẫu nhiên không trùng
    @objc func nextIndex() -> Int {
        var index = Random.next(under: quotes.count)
        
        while (index == lastIndex) { // Trong khi còn trùng
            index = Random.next(under: quotes.count) // sinh lại số khác
        }
        
        self.lastIndex = index // Lưu lại số sinh lần cuối
        
        return index
    }
    
    // Hiển thị câu trích dẫn theo chỉ số
    @objc func showQuote(index: Int) {
        quoteImageView.image = UIImage(named: quoteNames[index])
        quoteLabel.text = quotes[index]
    }
    
    // Hiển thị ngẫu nhiên một câu trích dẫn
    @objc func showRandomQuote() {
        let index = nextIndex() // Sinh chỉ mục ngẫu nhiên
        showQuote(index: index)
    }
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hiện câu trích dẫn đầu tiên
        showQuote(index: 0)
    
        // Cấu hình timer
        timer = Timer.scheduledTimer(
            timeInterval: interval, target: self,
            selector: #selector(showRandomQuote),
            userInfo: nil, repeats: true)
    }
}

