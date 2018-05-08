//
//  Image+CoreDataProperties.swift
//  QuickNote
//
//  Created by dev7 on 1/10/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var data: NSData?
    @NSManaged public var note: Note?

}
