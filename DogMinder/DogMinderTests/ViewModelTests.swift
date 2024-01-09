//
//  ViewModelTests.swift
//  DogMinderTests
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import XCTest

@testable import DogMinder
final class ViewModelTests: XCTestCase {

    var sut: ViewModel!
    let noteDescription = "Test Note"
    let noteComments = "Comments"
    
    override func setUpWithError() throws {
        sut = ViewModel()
      
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    //MARK: Create
    func testCreateSimpleNote() throws {
        
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.createNote(simple: noteDescription, date: .dateTest, comments: noteComments)
        let sutNote = try XCTUnwrap(sut.notes.first)
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.comments, "Comments")
        XCTAssertEqual(sutNote.description, "Test Note")
    }
    
    func testCreateExpenseNote() throws {
        let amount = 100.00
        
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.createNote(expense: noteDescription, amount: amount, date: .dateTest, comments: noteComments)
        let sutNote = try XCTUnwrap(sut.notes.first)
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.comments, noteComments)
        XCTAssertEqual(sutNote.value, Double(amount))
        XCTAssertEqual(sutNote.description, noteDescription)
        XCTAssertEqual(sutNote.type, .expense)
    }
    
    func testCreateEventNote() throws {
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.createNote(event: .accident, description: noteDescription, date: .dateTest, comments: noteComments)
        let sutNote = try XCTUnwrap(sut.notes.first)
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.description, noteDescription)
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, noteComments)
    }
    
    func testCreateMeasureNote() throws {
        let bodyPart = PetSize.chest
        let value = 60.0
        
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.createNote(bodyPart: bodyPart, value: value, date: .dateTest, comments: noteComments)
        let sutNote = try XCTUnwrap(sut.notes.first)
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.description, "Measure for \(bodyPart.rawValue) : \(value)")
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, noteComments)
    }
    
    func testSaveNoteCaseSimple() throws {
        let type = ReminderType.simple
        let amount = "60.0"
        let eventType = EventType.accident
        let bodyPart = PetSize.chest
        
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.saveNote(type: type, description: noteDescription, date: .dateTest, comments: noteComments, amount: amount, event: eventType, bodyPart: bodyPart)
        let sutNote = try XCTUnwrap(sut.notes.first)
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.type, .simple)
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, noteComments)
    }
    
    
    func testSaveNoteCaseExpense() throws {
        let type = ReminderType.expense
        let amount = "60.0"
        let eventType = EventType.accident
        let bodyPart = PetSize.chest
        
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.saveNote(type: type, description: noteDescription, date: .dateTest, comments: noteComments, amount: amount, event: eventType, bodyPart: bodyPart)
        
        let sutNote = try XCTUnwrap(sut.notes.first)
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.type, .expense)
        XCTAssertEqual(sutNote.value, Double(amount))
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, noteComments)
    }
    
    func testSaveNoteCaseEvent() throws {
        let type = ReminderType.event
        let amount = "60.0"
        let eventType = EventType.accident
        let bodyPart = PetSize.chest
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.saveNote(type: type, description: noteDescription, date: .dateTest, comments: noteComments, amount: amount, event: eventType, bodyPart: bodyPart)
        let sutNote = try XCTUnwrap(sut.notes.first)
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.type, type)
        XCTAssertEqual(sutNote.event, .accident)
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, noteComments)
    }
   
    func testSaveNoteCaseMeasure() throws {
        let type = ReminderType.measure
        let amount = "60.0"
        let eventType = EventType.accident
        let bodyPart = PetSize.chest
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.saveNote(type: type, description: noteDescription, date: .dateTest, comments: noteComments, amount: amount, event: eventType, bodyPart: bodyPart)
        let sutNote = try XCTUnwrap(sut.notes.first)
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sutNote.type, type)
        XCTAssertEqual(sutNote.measure, .chest)
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, noteComments)
    }
    
    //UPDATE
    func testUpdateNote() throws {
        let value = "60.0"
        let newEvent = EventType.treatment
        let newMeasure = PetSize.height
        let note = Note(id: .testUUID, type: .simple, description: noteDescription, value: Double(value)!, date: .dateTest, createdAt: .dateTest, comments: noteComments, measure: .chest, event: .accident, updatedAt: nil)
        sut.notes.append(note)
        let newDescription = noteDescription + " Updated"
        let newComments = noteComments + " Updated"
        
        sut.updateNote(id: .testUUID, type: .simple, newDescription: newDescription, newDate: .dateTest, newComments: newComments, newAmount: value, newEvent: newEvent, newBodyPart: newMeasure)
        let noteUpdated = try XCTUnwrap(sut.notes.first(where: { $0.id == note.id }))
        
        XCTAssertEqual(noteUpdated.description, newDescription)
        XCTAssertEqual(noteUpdated.comments, newComments)
        
    }
    
    //MARK: Delete
    
    func testRemoveNote()  throws {
        let value = "60.0"
        let newEvent = EventType.treatment
        let newMeasure = PetSize.height
    
        let note = Note(id: .testUUID, type: .simple, description: noteDescription, value: Double(value)!, date: .dateTest, createdAt: .dateTest, comments: noteComments, measure: .chest, event: .accident, updatedAt: nil)
        XCTAssertEqual(sut.notes.count, 0)
        sut.notes.append(note)
        XCTAssertEqual(sut.notes.count, 1)
        
        sut.removeNote(id: .testUUID)
        XCTAssertEqual(sut.notes.count, 0)
    }
}
