//
//  WatchMovie+CoreDataProperties.swift
//  Film
//
//  Created by Tomas Vosicky on 17.01.17.
//  Copyright © 2017 Tomas Vosicky. All rights reserved.
//

import Foundation
import CoreData


extension WatchMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchMovie> {
        return NSFetchRequest<WatchMovie>(entityName: "WatchMovie");
    }

    @NSManaged public var id: Int
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var category: String?

}
