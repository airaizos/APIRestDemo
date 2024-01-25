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
}
