//
//  TagsController.swift
//  QuickNote
//
//  Created by dev7 on 1/9/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import UIKit
import CoreData

class TagsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: *** Data model
    var tags = [NSManagedObject]()
        
    // MARK: *** UI Elements
    
    // MARK: *** UI events
    
    // MARK: *** Local variables
    
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nạp danh sách toàn bộ các tag
        tags = Tag.all()
    }
    
    // MARK: *** UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count + 1 // Thêm All
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCellID") as! TagCell
        
        if (indexPath.row == 0 ) {
            cell.tagLabel.text = "All (\(Note.all().count))"
        } else {
            let tag = tags[indexPath.row - 1] as! Tag
            cell.tagLabel.text = "\(tag.name!) (\(tag.notes!.count))"
        }
        
        return cell
    }

    var selectedTagName = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTagName = indexPath.row == 0 ? "All" : (tags[indexPath.row - 1] as! Tag).name!
        performSegue(withIdentifier: "SegueShowNoteOfTagID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowNoteOfTagID" {
            let dest = segue.destination as! NotesController
            dest.tagName = selectedTagName
        }
    }
}
