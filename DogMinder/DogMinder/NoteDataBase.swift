//
//  NoteDataBase.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation
import CoreData

final class NoteDataBase: PersistenceProtocol {
    
    static let shared = NoteDataBase()
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext = CoreDataContainer.shared.container.viewContext ) {
        self.context = context
    }
//    let context = CoreDataContainer.shared.container.viewContext

    
    func fetchAll() throws -> [Note] {
        let request = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NoteEntity.date, ascending: true)]
        do {
            let notes = try context.fetch(request)
            return notes.map{ $0.getNote() }
        } catch {
            throw DataBaseError.fetch
        }
    }
    
    func insert(note: Note) throws {
        let newNote = note.getNoteEntity(from: note, in: context)
        context.insert(newNote)
        do {
            try context.save()
        } catch {
            throw DataBaseError.insert
        }
    }
    
    func update(id: UUID, type: ReminderType, newDescription: String, newDate: Date, newComments: String, newAmount: String, newEvent: EventType, newBodyPart: PetSize) throws {
    
        do {
            guard let note = noteQuery(by: id) else { throw DataBaseError.update }
                note.reminderType = type.rawValue
                note.title = newDescription
                note.date = newDate
                note.comments = newComments
                note.value = Double(newAmount) ?? 0
                note.event = newEvent.rawValue
                note.measure = newBodyPart.rawValue
                note.updatedAt = Date.now
            
            try context.save()
            
        } catch {
            throw DataBaseError.update
        }
    }
    
    func delete(id: UUID) throws {
        guard let note = noteQuery(by: id) else { throw DataBaseError.delete }
        context.delete(note)
    }
    
    func noteQuery(by id: UUID) -> NoteEntity? {
        let request = NoteEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "%K = %i", id.uuidString,"id")
        
        return try? context.fetch(request).first
    }
    
}
