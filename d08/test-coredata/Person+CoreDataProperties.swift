//
//  Person+CoreDataProperties.swift
//  test-coredata
//
//  Created by Clementine URQUIZAR on 4/3/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: NSDecimalNumber?
    @NSManaged public var name: String?

}
