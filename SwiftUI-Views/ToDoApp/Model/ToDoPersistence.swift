//
//  Persistence.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/17.
//

/*
 
 1. Create an entity in the managed object model(i.e..xcdatamodeld)
 2. Define a managed object, which inherits from NSManagedObject , to associate with the entity
 3. In the views that needs to save and update the data, get the managed object context from the environment using @Environment like this:
                    ` @Environment(\.managedObjectContext) var context`
 
 And then create the managed object and use the save method of the context to add the object to the database.
 */

import Foundation
import CoreData

struct ToDoPersistenceController {
    static let shared = ToDoPersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDoList") //match data model file name: ToDoList.xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError()
            }
        }
    }
    
    //for preview
    static var preview: ToDoPersistenceController = {
        let result = ToDoPersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
            let newItem = ToDoItem(context: viewContext)
            newItem.id = UUID()
            newItem.name = "To do item #\(index)"
            newItem.priority = .normal
            newItem.isComplete = false
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and termina te. You should not use this function in a shipping application, although it may be
            //     useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)") }
        return result
    }()
}
