//
//  Image+CoreDataProperties.swift
//  Countdown
//
//  Created by Richard Eccles on 1/25/17.
//  Copyright © 2017 Richard Eccles. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toEntry: Entry?

}
