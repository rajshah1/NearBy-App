//
//  Favourites+CoreDataProperties.swift
//  
//
//  Created by Raj Shah on 14/11/17.
//
//

import Foundation
import CoreData


extension Favourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites")
    }

    @NSManaged public var favouriteID: String?
    @NSManaged public var favoriteName: String?
    @NSManaged public var favouriteVicinity: String?

}
