//
//  FetchAllNotesUseCase.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation


struct FetchAllNotesUseCase {
    var notesDataBase: PersistenceProtocol
    
    init(notesDataBase: PersistenceProtocol = NoteDataBase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    func fetchAll() throws -> [Note] {
        try notesDataBase.fetchAll()
    }
    
}
