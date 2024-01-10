//
//  RemoveNoteUseCase.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 10/1/24.
//

import Foundation

struct RemoveNoteUseCase: NoteRemover {
    var notesDataBase: PersistenceProtocol
    
    init(notesDataBase: PersistenceProtocol = NoteDataBase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    func removeNote(id: UUID) throws {
        try notesDataBase.delete(id: id)
    }
}
