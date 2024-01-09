//
//  DogMinderApp.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI
import CoreData

@main
struct DogMinderApp: App {
   // let persistenceController = CoreDataContainer.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        //        .environment(\.managedObjectContext, persistenceController)
        }
    }
}
