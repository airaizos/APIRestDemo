//
//  UseCasesProtocols.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 10/1/24.
//

import Foundation



protocol NoteCreator {
    func createNote(simple: String, date: Date, comments: String) throws
    
    func createNote(expense: String, amount: Double, date: Date, comments:String) throws
    
    func createNote(event: EventType, title: String, date: Date, comments: String) throws
    func createNote(bodyPart: PetSize, value: Double,  date: Date, comments:String) throws
    
    func createNote(type: ReminderType, title: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) throws
}

protocol NoteFetcher {
    func fetchAll() throws -> [Note]
}


protocol NoteUpdater {
    func updateNote(id: UUID, type: ReminderType, newTitle: String, newDate: Date, newComments: String, newAmount: String, newEvent:EventType, newBodyPart: PetSize) throws
}

protocol NoteRemover {
    func removeNote(id: UUID) throws
}
