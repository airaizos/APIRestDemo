//
//  UseCaseMock.swift
//  DogMinderTests
//
//  Created by Adrian Iraizos Mendoza on 10/1/24.
//

import Foundation
@testable import DogMinder

var mockDataBase = [Note]()

struct MockCreateNote: NoteCreator {
    func createNote(simple: String, date: Date, comments: String) throws {
        let testNote = Note(simpleReminder: simple, date: date, comments: comments)
        mockDataBase.append(testNote)
    }
    
    func createNote(expense: String, amount: Double, date: Date, comments: String) throws {
        let testNote = Note(expense: expense, amount: amount, date: date, comments: comments)
        mockDataBase.append(testNote)
    }
    
    func createNote(event: DogMinder.EventType, title: String, date: Date, comments: String) throws {
        let testNote = Note(eventType: event, title: title, date: date, comments: comments)
        mockDataBase.append(testNote)
    }
    
    func createNote(bodyPart: DogMinder.PetSize, value: Double, date: Date, comments: String) throws {
        let testNote = Note(bodyPart: bodyPart, value: value, date: date, comments: comments)
        mockDataBase.append(testNote)
    }
    
    func createNote(type: DogMinder.ReminderType, title: String, date: Date, comments: String, amount: String, event: DogMinder.EventType, bodyPart: DogMinder.PetSize) throws {
        let value = Double(amount) ?? 0
        switch type {
        case .simple: try createNote(simple: title, date: date, comments: comments)
        case .expense: try createNote(expense: title, amount: value, date: date, comments: comments)
        case .measure: try createNote(bodyPart: bodyPart, value: value, date: date, comments: comments)
        case .event: try createNote(event: event, title: title, date: date, comments: comments)
        }
    }
}

struct MockFetchNote: NoteFetcher {
    func fetchAll() throws -> [DogMinder.Note] {
        mockDataBase
    }
}

struct MockUpdateNote: NoteUpdater {
    func updateNote(id: UUID, type: DogMinder.ReminderType, newTitle: String, newDate: Date, newComments: String, newAmount: String, newEvent: DogMinder.EventType, newBodyPart: DogMinder.PetSize) throws {
        if let index = mockDataBase.firstIndex(where: { $0.id == id }) {
            let newValue = Double(newAmount) ?? 0
            let updatedNote = Note(id: id, type: type, title: newTitle, value: newValue, date: newDate, comments: newComments, measure: newBodyPart, event: newEvent, updatedAt: Date.now)
            mockDataBase[index] = updatedNote
        }
    }
    
}

struct MockRemoveNote: NoteRemover {
    func removeNote(id: UUID) throws {
        if let index = mockDataBase.firstIndex(where:  { $0.id == id }) {
            mockDataBase.remove(at: index)
        }
    }
    
    
}
