//
//  AddedBook+CoreDataProperties.swift
//  BookShelf
//
//  Created by 예슬 on 5/10/24.
//
//

import Foundation
import CoreData


extension AddedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddedBook> {
        return NSFetchRequest<AddedBook>(entityName: "AddedBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var thumbnail: String?

}

extension AddedBook : Identifiable {

}
