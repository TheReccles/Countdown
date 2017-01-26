//
//  Entry+CoreDataProperties.swift
//  Countdown
//
//  Created by Richard Eccles on 1/25/17.
//  Copyright © 2017 Richard Eccles. All rights reserved.
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var dateEnd: NSDate?
    @NSManaged public var isRepeated: Bool
    @NSManaged public var reminderType: String?
    @NSManaged public var toImage: Image?

}
