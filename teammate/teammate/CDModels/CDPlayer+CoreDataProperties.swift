//
//  CDPlayer+CoreDataProperties.swift
//  teammate
//
//  Created by user256828 on 5/22/24.
//
//

import Foundation
import CoreData


extension CDPlayer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPlayer> {
        return NSFetchRequest<CDPlayer>(entityName: "CDPlayer")
    }

    @NSManaged public var dateOfBirth: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var nationality: String?
    @NSManaged public var position: String?
    @NSManaged public var profileImageURL: String?
    @NSManaged public var shirtNumber: String?
    @NSManaged public var team: CDTeam?

}

extension CDPlayer : Identifiable {

}
