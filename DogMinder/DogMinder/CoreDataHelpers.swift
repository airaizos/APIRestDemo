//
//  Helpers.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation
import CoreData

//MARK: NoteEntity
extension Note {
    
    func getNoteEntity(from note: Note, in context: NSManagedObjectContext) -> NoteEntity {
        let newItem = NoteEntity(context: context)
        newItem.id = note.id
        newItem.createdAt = note.createdAt
        newItem.reminderType = note.type.rawValue
        newItem.title = note.title
        newItem.date = note.date
        newItem.value = note.value ?? 0
        newItem.comments = note.comments
        newItem.measure = note.measure?.rawValue
        newItem.event = note.event?.rawValue
        newItem.updatedAt = note.updatedAt
        
        return newItem
    }
}
