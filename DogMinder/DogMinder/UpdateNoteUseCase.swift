//
//  UpdateNoteUseCase.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 10/1/24.
//

import Foundation

struct UpdateNoteUseCase: NoteUpdater {
    var notesDataBase: PersistenceProtocol
    
    init(notesDataBase: PersistenceProtocol = NoteDataBase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    func updateNote(id: UUID, type: ReminderType, newTitle: String, newDate: Date, newComments: String, newAmount: String, newEvent: EventType, newBodyPart: PetSize) throws {
       try notesDataBase.update(id: id, type: type, newTitle: newTitle, newDate: newDate, newComments: newComments, newAmount: newAmount, newEvent: newEvent, newBodyPart: newBodyPart)
    }
}
