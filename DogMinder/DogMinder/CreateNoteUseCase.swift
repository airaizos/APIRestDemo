//
//  CreateNoteUseCase.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation

struct CreateNoteUseCase: NoteCreator {
    var notesDataBase: PersistenceProtocol
    
    init(notesDataBase: PersistenceProtocol = NoteDataBase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    /// Crea nota simple
    func createNote(simple: String, date: Date, comments: String) throws {
        let note = Note(simpleReminder: simple, date: date, comments: comments)
        try notesDataBase.insert(note: note)
    }
    
    ///Crea nota para Gastos
    func createNote(expense: String, amount: Double, date: Date, comments:String) throws {
        let note = Note(expense: expense, amount: amount, date: date, comments: comments)
        try notesDataBase.insert(note: note)
    }
    
    ///Crea una nota de tipo de Evento
    func createNote(event: EventType, title: String, date: Date, comments: String) throws {
        let note = Note(eventType: event, title: title, date: date, comments: comments)
        try notesDataBase.insert(note: note)
    }
    
    ///Crea notea de tipo Measure
    func createNote(bodyPart: PetSize, value: Double,  date: Date, comments:String) throws {
        let note = Note(bodyPart: bodyPart, value: value, date: date, comments: comments)
        try notesDataBase.insert(note: note)
    }
    
    ///Guarda la información dada por la vista
    func createNote(type: ReminderType, title: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) throws {
        let value = Double(amount) ?? 0
        
        switch type {
        case .simple: try createNote(simple: title, date: date, comments: comments)
        case .expense: try createNote(expense: title, amount: value, date: date, comments: comments)
        case .event: try createNote(event: event, title: title, date: date, comments: comments)
        case .measure: try createNote(bodyPart: bodyPart, value: value, date: date, comments: comments)
        }
    }
}
