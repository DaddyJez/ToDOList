//
//  TaskEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Влад Карагодин on 11.02.2025.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var completed: Bool
    @NSManaged public var userId: Int32
    @NSManaged public var date: String?

}

extension TaskEntity : Identifiable {

}
