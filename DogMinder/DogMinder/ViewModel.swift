//
//  ViewModel.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI
import Observation


final class ViewModel: ObservableObject {

    var createNoteUseCase: NoteCreator
    var fetchAllNotesUseCase: NoteFetcher
    var updateNoteUseCase: NoteUpdater
    var removeNoteUseCase: NoteRemover
    
    @Published var notes: [Note]
    @Published var noteFilter: ReminderType? = nil
    
    var filteredNotes: [Note] {
        switch noteFilter {
        case nil: notes.sorted { $0.date > $1.date }
        default: notes.filter { $0.type == noteFilter }.sorted{ $0.date > $1.date }
        }
    }
    
    @Published var showError = false
    @Published var errorMessage: (title: String, message: String) = ("","")
    
    init(reminders: [Note] = [], createNoteUseCase: NoteCreator = CreateNoteUseCase(), fetchAllNotesUseCase: NoteFetcher = FetchAllNotesUseCase(), updateNoteUseCase: NoteUpdater = UpdateNoteUseCase(), removeNoteUseCase: NoteRemover = RemoveNoteUseCase()) {
        self.notes = reminders
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.removeNoteUseCase = removeNoteUseCase
        fetchAllNotes()
    }
    
    ///Guarda la información dada por la vista
    func saveNote(type: ReminderType, title: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) {
        do {
            try createNoteUseCase.createNote(type: type, title:title, date: date, comments: comments, amount: amount, event:event, bodyPart: bodyPart )
            fetchAllNotes()
        } catch {
            showError.toggle()
            errorMessage.title = "Error Saving Note"
            errorMessage.message = "Can't save the note"
        }
    }
    
    //MARK: Fetch Notes
    func fetchAllNotes() {
        do {
            notes = try fetchAllNotesUseCase.fetchAll()
        } catch {
            showError.toggle()
            errorMessage.title = "Error Fetching notes"
            errorMessage.message = "Can't load notes"
        }
    }
    
    //MARK: Updates
    
    ///Guarda la nota con la información dada por la vista
    func updateNote(id: UUID, type: ReminderType, newTitle: String, newDate: Date, newComments: String, newAmount: String, newEvent:EventType, newBodyPart: PetSize) {
        do {
            try updateNoteUseCase.updateNote(id: id, type: type, newTitle: newTitle, newDate: newDate, newComments: newComments, newAmount: newAmount, newEvent: newEvent, newBodyPart: newBodyPart)
            fetchAllNotes()
        } catch {
            showError.toggle()
            errorMessage.title = "Error Updating note"
            errorMessage.message = "Can't update note"
        }
    }
    
    //MARK: Remove
    func removeNote(id: UUID) {
        do {
            try removeNoteUseCase.removeNote(id: id)
            fetchAllNotes()
        } catch {
            showError.toggle()
            errorMessage.title = "Error Deleting note"
            errorMessage.message = "Can't delete note"
        }
    }
    
    //MARK: View
    func countNotes(for type: ReminderType) -> Int {
        notes.filter { $0.type == type }.count
    }
}
