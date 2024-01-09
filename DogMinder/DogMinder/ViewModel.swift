//
//  ViewModel.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI
import Observation

@Observable
final class ViewModel {
    var notes: [Note]
    
    init(reminders: [Note] = []) {
        self.notes = reminders
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
        let reminder = Note(eventType: event, description: description, date: date, comments: comments)
        notes.append(reminder)
    }
    
    ///Crea una nota de medida del cuerpo
    func createNote(bodyPart: PetSize, value: Double,  date: Date, comments:String) {
        let reminder = Note(bodyPart: bodyPart, value: value, date: date, comments: comments)
        notes.append(reminder)
    }
    
    ///Guarda la información dada por la vista
    func saveNote(type: ReminderType, description: String, date: Date, comments: String, amount: String, event:EventType, bodyPart: PetSize) {
        let value = Double(amount) ?? 0
        
        switch type {
        case .simple: createNote(simple: description, date: date, comments: comments)
        case .expense: createNote(expense: description, amount: value, date: date, comments: comments)
        case .event: createNote(event: event, description: description, date: date, comments: comments)
        case .measure: createNote(bodyPart: bodyPart, value: value, date: date, comments: comments)
        }
    }

  //MARK: Updates
    
    ///Actualiza una nota simple
    func updateNote(simple newDescription: String, id: UUID, newDate: Date, newComments:String) {
        if let index = notes.firstIndex(where:  {$0.id == id }) {
            let updatedNote = Note(simpleReminder: newDescription, date: newDate, comments: newComments)
            notes[index] = updatedNote
        }
    }
    
    ///Actualiza una nota de gastos
    func updateNote(expense: String, id: UUID, newAmount: Double, newDate: Date, newComments:String) {
        if let index = notes.firstIndex(where:  {$0.id == id }) {
            let updatedNote = Note(expense: expense, amount: newAmount, date: newDate, comments: newComments)
            notes[index] = updatedNote
        }
    }
    
    ///Actualiza una nota de evento
    func updateNote(event: EventType, id: UUID, newDescription: String, newDate: Date, newComments:String) {
        if let index = notes.firstIndex(where:  {$0.id == id }) {
            let updatedNote = Note(eventType: event, description: newDescription, date: newDate, comments: newComments)
            notes[index] = updatedNote
        }
    }
    
    ///Actualiza una nota de medida del cuerpo
    func updateNote(bodyPart: PetSize, id: UUID, newValue: Double, newDate: Date, newComments:String) {
        if let index = notes.firstIndex(where:  {$0.id == id }) {
            let updatedNote = Note(bodyPart: bodyPart, value: newValue, date: newDate, comments: newComments)
            notes[index] = updatedNote
        }
    }

    ///Guarda la información dada por la vista
    func updateNote(id: UUID, type: ReminderType, newDescription: String, newDate: Date, newComments: String, newAmount: String, newEvent:EventType, newBodyPart: PetSize) {
        let value = Double(newAmount) ?? 0
        
        switch type {
        case .simple: updateNote(simple: newDescription, id: id, newDate: newDate, newComments: newComments)
        case .expense: updateNote(expense: newDescription, id: id, newAmount: value, newDate: newDate, newComments: newComments)
        case .event: updateNote(event: newEvent,id: id, newDescription: newDescription, newDate: newDate, newComments: newComments)
        case .measure: updateNote(bodyPart: newBodyPart,id: id, newValue: value, newDate: newDate, newComments: newComments)
        }
    }
    //MARK: Remove
    func removeNote(id: UUID) {
        notes.removeAll(where: { $0.id == id })
   
    }

}
