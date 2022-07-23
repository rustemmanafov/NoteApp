//
//  List+CoreDataProperties.swift
//  NoteApp
//
//  Created by Rustem Manafov on 24.07.22.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var title: String?

}

extension List : Identifiable {

}
