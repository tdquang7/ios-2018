//
//  Tag+CoreDataClass.swift
//  QuickNote
//
//  Created by dev7 on 1/9/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import Foundation
import CoreData


public class Tag: NSManagedObject {
    static let entityName = "Tag"
    
    // Lấy tất cả danh sách
    static func all() -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        do {
            let list = try DB.MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            return list
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Tạo mới một đối tượng để chèn vào CSDl
    static func create() -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: DB.MOC)
    }
    
    // Tìm một tag bằng tên của tag đó
    static func getBy(tag name: String) -> Tag? {
        let fetchRequest: NSFetchRequest<Tag> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            if let list = try DB.MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as? [Tag] {
                if list.count > 0 {
                    return list[0]
                }
                return nil
            }
        }catch let error as NSError{
            print("Cannot get Tag by tagname, \(error), \(error.userInfo)");
        }
        
        return nil
    }
    
    // Chèn một tag vào CSDl
    static func insert(tag name: String) -> Tag? {
        let newTag = create() as! Tag
        newTag.name = name
        
        do {
            try DB.MOC.save()
            return newTag
        } catch let error as NSError{
            print("Cannot get Tag by tagname, \(error), \(error.userInfo)");
        }
        
        return nil
    }
    
    // Kiểm tra coi có hay chưa, nếu chưa có thì chèn vào, nếu có rồi thì trả ra đối tượng
    static func findAndCreate(tag name: String) -> Tag? {
        if let tag = getBy(tag: name) {
            return tag
        } else {
            return insert(tag: name)
        }
    }
    
    // Lấy tất cả các notes thuộc tagname nhất định
    static func getNotes(by tagname: String) -> [Note] {
        let fetchRequest:NSFetchRequest<Tag> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", tagname)
        
        do {
            let list = try DB.MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Tag]
            let item = list.first!
            
            return item.notes?.allObjects as! [Note]
        } catch let error as NSError {
            print("Cannot fetch notes, error: \(error), \(error.userInfo)")
            return []
        }
    }

}
