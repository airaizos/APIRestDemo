//
//  CreateNoteUseCase.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation

struct CreateNoteUseCase {
    var notesDataBase: PersistenceProtocol
    
    init(notesDataBase: PersistenceProtocol = NoteDataBase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    func createNote(type: ReminderType, title: String, value: Double?, date: Date, comments: String?, measure: PetSize?, event: EventType?) throws {
        let note = Note(type: type, title: title, value: value, date: date, comments: comments, measure: measure, event: event)
        try notesDataBase.insert(note: note)
    }
}
