//
//  SwiftUI_ViewsApp.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("first call method, for 3rd sdk use")
        return true
    }
}

@main
struct SwiftUI_ViewsApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let todoPersistenseController = ToDoPersistenceController.shared
    
    let pfPersistenseController = PFPersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            /*
             we inject the managed object context into the environment of ContentView.
             This allows us to easily access the context in the content view for managing the data in the database.
             */
            //ToDoContentView().environment(\.managedObjectContext, todoPersistenseController.container.viewContext)
            
            DashboardView().environment(\.managedObjectContext, pfPersistenseController.container.viewContext)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
