//
//  ToDoItem.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/17.
//

import Foundation
import CoreData

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}

///for memory save
//class ToDoItem: ObservableObject, Identifiable {
//    var id = UUID()
//    @Published var name: String = ""
//    @Published var priority: Priority = .normal
//    @Published var isComplete: Bool = false
//
//    init(name: String, priority: Priority = .normal, isComplete: Bool = false) {
//        self.name = name
//        self.priority = priority
//        self.isComplete = isComplete
//    }
//}

///for coredata save
/*
 The model class of Core Data should be inherited from NSManagedObject . Each property is annotated with @NSManaged and corresponds to the attribute of the Core Data model we created earlier. By using @NSManaged , this tells the compiler that the property is taken care by Core Data
 */
//NSManagedObject . It conforms to ObservableObject
public class ToDoItem: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var priorityNum: Int32
    @NSManaged public var isComplete: Bool
}

extension ToDoItem: Identifiable {
    var priority: Priority {
        get {
            return Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
}
