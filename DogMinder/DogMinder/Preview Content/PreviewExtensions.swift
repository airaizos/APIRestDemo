//
//  PreviewExtensions.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation

extension ViewModel {
    static var previewViewModel: ViewModel {
        
        let context = CoreDataContainer(forPreview: true).container.viewContext
        let noteDataBase = NoteDataBase(context: context)
        
        return ViewModel(reminders: [], createNoteUseCase: CreateNoteUseCase(notesDataBase: noteDataBase), fetchAllNotesUseCase: FetchAllNotesUseCase(notesDataBase: noteDataBase), updateNoteUseCase: UpdateNoteUseCase(notesDataBase: noteDataBase), removeNoteUseCase: RemoveNoteUseCase(notesDataBase: noteDataBase))
    }
    
}
