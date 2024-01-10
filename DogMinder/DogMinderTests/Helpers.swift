//
//  Helpers.swift
//  DogMinderTests
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation

@testable import DogMinder
extension UUID {
    static let testUUID = UUID(uuidString: "0679B32D-C309-48D7-BA95-6426CEF897AF")!
}


struct TestNote {
    let type = ReminderType.event
    let title = "Test Note"
    let comments = "Comments"
    let amount = "60.00"
    let date = Date.dateTest
    let eventType = EventType.accident
    let bodyPart = PetSize.chest
}

//extension ViewModel {
//    static var testViewModel: ViewModel {
//        
//        let context = CoreDataContainer(forPreview: true).container.viewContext
//        let noteDataBase = NoteDataBase(context: context)
//        
//        return ViewModel(reminders: [], createNoteUseCase: CreateNoteUseCase(notesDataBase: noteDataBase), fetchAllNotesUseCase: FetchAllNotesUseCase(notesDataBase: noteDataBase), updateNoteUseCase: UpdateNoteUseCase(notesDataBase: noteDataBase))
//    }
//    
//}
