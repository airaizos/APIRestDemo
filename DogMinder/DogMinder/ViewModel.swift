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
    
    @Published var notes: [Note]
    @Published var showError = false
    @Published var errorMessage: (title: String, message: String) = ("","")
    
    init(reminders: [Note] = [], createNoteUseCase: NoteCreator = CreateNoteUseCase(), fetchAllNotesUseCase: NoteFetcher = FetchAllNotesUseCase()) {
        self.notes = reminders
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        fetchAllNotes()
    }
    
    ///Guarda la información dada por la vista
    func saveNote(type: ReminderType, title: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) {
        let value = Double(amount) ?? 0
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
    func updateNote(id: UUID, type: ReminderType, newDescription: String, newDate: Date, newComments: String, newAmount: String, newEvent:EventType, newBodyPart: PetSize) {
        
        if let index = notes.firstIndex(where:  {$0.id == id }) {
            let value = Double(newAmount) ?? 0
            let updatedNote = Note(id: id, type: type, title: newDescription, value: value, date: newDate, createdAt: notes[index].createdAt, comments: newComments, measure: newBodyPart, event: newEvent, updatedAt: Date.now)
            notes[index] = updatedNote
        }
    }
    
    //MARK: Remove
    func removeNote(id: UUID) {
        notes.removeAll(where: { $0.id == id })
        
    }
    
}
