//
//  Topics+CoreDataProperties.swift
//  
//
//  Created by Dylan Sharkey on 3/17/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Topics {

    @NSManaged var name: String?
    @NSManaged var votes: NSNumber?

}
