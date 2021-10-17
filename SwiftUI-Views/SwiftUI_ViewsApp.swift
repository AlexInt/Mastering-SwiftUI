//
//  SwiftUI_ViewsApp.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//

import SwiftUI

@main
struct SwiftUI_ViewsApp: App {
    let persistenseController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            /*
             we inject the managed object context into the environment of ContentView . This allows us to easily access the context in the content view for managing the data in the database.
             */
            ToDoContentView()
                .environment(\.managedObjectContext, persistenseController.container.viewContext)
        }
    }
}
