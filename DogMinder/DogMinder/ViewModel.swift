//
//  ViewModel.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI
import Observation


final class ViewModel: ObservableObject {

    var createNoteUseCase: CreateNoteUseCase
    var fetchAllNotesUseCase: FetchAllNotesUseCase
    
    @Published var notes: [Note]
    @Published var showError = false
    @Published var errorMessage: (title: String, message: String) = ("","")
    
    init(reminders: [Note] = [], createNoteUseCase: CreateNoteUseCase = CreateNoteUseCase(),fetchAllNotesUseCase: FetchAllNotesUseCase = FetchAllNotesUseCase()) {
        self.notes = reminders
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        fetchAllNotes()
    }
    
    //MARK: Create Reminder Type
    
    ///Crea nota Simple
    func createNote(simple: String, date: Date, comments: String) {
        let reminder = Note(simpleReminder: simple, date: date, comments: comments)
        notes.append(reminder)
    }
    
    ///Crea nota para Gastos
    func createNote(expense: String, amount: Double, date: Date, comments:String) {
        let reminder = Note(expense: expense, amount: amount, date: date, comments: comments)
        notes.append(reminder)
    }
    
    ///Crea una nota de tipo de Evento
    func createNote(event: EventType, description: String, date: Date, comments: String) {
        let reminder = Note(eventType: event, title: description, date: date, comments: comments)
        notes.append(reminder)
    }
    
    ///Crea una nota de medida del cuerpo
    func createNote(bodyPart: PetSize, value: Double,  date: Date, comments:String) {
        let reminder = Note(bodyPart: bodyPart, value: value, date: date, comments: comments)
        notes.append(reminder)
    }
    
    ///Guarda la información dada por la vista
    //    func saveNote(type: ReminderType, description: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) {
    //        let value = Double(amount) ?? 0
    //
    //        switch type {
    //        case .simple: createNote(simple: description, date: date, comments: comments)
    //        case .expense: createNote(expense: description, amount: value, date: date, comments: comments)
    //        case .event: createNote(event: event, description: description, date: date, comments: comments)
    //        case .measure: createNote(bodyPart: bodyPart, value: value, date: date, comments: comments)
    //        }
    //    }
    
    ///Guarda la información dada por la vista
    func saveNote(type: ReminderType, description: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) {
        let value = Double(amount) ?? 0
        do {
            try createNoteUseCase.createNote(type: type, title: description, value: value, date: date, comments: comments, measure: bodyPart, event: event)
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
