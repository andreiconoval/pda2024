//
//  CDTeam+CoreDataProperties.swift
//  teammate
//
//  Created by user256828 on 5/22/24.
//
//

import Foundation
import CoreData


extension CDTeam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTeam> {
        return NSFetchRequest<CDTeam>(entityName: "CDTeam")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var player: NSSet?

}

// MARK: Generated accessors for player
extension CDTeam {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: CDPlayer)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: CDPlayer)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}

extension CDTeam : Identifiable {

}
