//
//  CoreDataContainer.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation
import CoreData

final class CoreDataContainer {
    static let shared = CoreDataContainer()
    
    let container:NSPersistentContainer
    
    init(forPreview: Bool = false) {
        container = NSPersistentContainer(name: "DogminderDataModel")
        
        if forPreview {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        container.viewContext.name = "DogminderDataModel"
    }
}
