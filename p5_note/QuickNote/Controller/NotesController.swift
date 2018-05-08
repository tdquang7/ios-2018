//
//  NotesController.swift
//  QuickNote
//
//  Created by dev7 on 1/9/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import UIKit
import CoreData

protocol NotesControllerDelegate {
    func addNote(newNote: Note)
}

class NotesController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesControllerDelegate, NoteEditControllerDelegate {
    // MARK: *** Data model
    var notes = [NSManagedObject]()
    var tagName = "All"
    
    // MARK: *** UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: *** UI events
    @IBAction func addNoteButton_Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueNoteDetailID", sender: self)
    }
    
    // MARK: *** Local variables
    
    
    // MARK: *** UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tagName == "All" {
            notes = Note.all()
        } else {
            notes = Tag.getNotes(by : tagName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData() // Cập nhật giao diện
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueNoteDetailID" {
            let dest = segue.destination as! NoteDetailController
            dest.mode = "Add"
            dest.delegate = self
        } else if segue.identifier == "SegueNoteEditID" {
            let dest = segue.destination as! NoteEditController
            dest.note = self.selectedNote
            dest.delegate = self
        }
    }
    
    func addNote(newNote: Note) {
        notes += [newNote] // Cập nhật data model
    }
    
    
    // MARK: *** UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tagName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row] as! Note
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellID") as! NoteCell
        cell.notePreviewLabel.text = note.preview
        
        // Hiển thị một hình ảnh của note nếu có
        let a = note.images?.allObjects as! Array<Image>
        if a.count > 0 {
            cell.noteImageView.image = UIImage(data: a[0].data as! Data)
        }
        
        return cell
    }
    
    var selectedNote: Note?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row] as? Note
        performSegue(withIdentifier: "SegueNoteEditID", sender: self)
    }
    
    // MARK: *** NoteEditControllerDelegate
    func doneEditing() {
        tableView.reloadData() // Cập nhật giao diện
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            DB.MOC.delete(note)
            notes.remove(at: indexPath.row) // Cập nhật data model
            
            DB.save() // Cập nhật CSDL
            tableView.deleteRows(at: [indexPath], with: .fade) // Cập nhật giao diện
        }
    }
}

