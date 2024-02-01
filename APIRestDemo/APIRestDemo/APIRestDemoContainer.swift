//
//  APIRestDemoContainer.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 25/1/24.
//

import Foundation
import CoreData


final class APIRestDemoContainer {
    static let shared = APIRestDemoContainer()
    
    let container: NSPersistentContainer
    
    init(forPreview: Bool = false) {
        self.container = NSPersistentContainer(name: "APIRestDemoDataModel")
        
        if forPreview {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        container.viewContext.name = "APIRestDemoDataModel"
        
    }
    
    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
