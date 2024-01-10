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
    let testNote = TestNote()
    
    override func setUpWithError() throws {
      let mockCreateNote = MockCreateNote()
      let mockFetchNote = MockFetchNote()
      let mockUpdateNote = MockUpdateNote()
        sut = ViewModel(createNoteUseCase: mockCreateNote, fetchAllNotesUseCase: mockFetchNote, updateNoteUseCase: mockUpdateNote)
                        
    }
    
    override func tearDownWithError() throws {
        mockDataBase = []
        sut = nil
    }

    //MARK: Create
    func testCreateSimpleNote() throws {
        XCTAssertEqual(mockDataBase.count, 0)
        
        try sut.createNoteUseCase.createNote(type: .simple, title: testNote.title, date: .dateTest, comments: testNote.comments, amount: testNote.amount, event: testNote.eventType, bodyPart: testNote.bodyPart)
        print(mockDataBase.count,"Cuenta")
        let sutNote = try XCTUnwrap(mockDataBase.first)
        XCTAssertEqual(mockDataBase.count, 1)
        XCTAssertEqual(sutNote.comments, "Comments")
        XCTAssertEqual(sutNote.title, "Test Note")
        
        XCTAssertNil(sutNote.value)
        XCTAssertNil(sutNote.event)
        XCTAssertNil(sutNote.measure)
    }
    
    func testCreateExpenseNote() throws {
        let value = try XCTUnwrap(Double(testNote.amount))
        XCTAssertEqual(mockDataBase.count, 0)
        
        try sut.createNoteUseCase.createNote(type: .expense, title: testNote.title, date: .dateTest, comments: testNote.comments, amount: testNote.amount, event: testNote.eventType, bodyPart: testNote.bodyPart)
        
        let sutNote = try XCTUnwrap(mockDataBase.first)
        
        XCTAssertEqual(mockDataBase.count, 1)
        
        XCTAssertEqual(sutNote.comments, testNote.comments)
        XCTAssertEqual(sutNote.value, value)
        XCTAssertEqual(sutNote.title, testNote.title)
        XCTAssertEqual(sutNote.type, .expense)
    }
    

    func testCreateEventNote() throws {
        XCTAssertEqual(mockDataBase.count, 0)
        
        try sut.createNoteUseCase.createNote(type: .event, title: testNote.title, date: .dateTest, comments: testNote.comments, amount: testNote.amount, event: testNote.eventType, bodyPart: testNote.bodyPart)
        
        let sutNote = try XCTUnwrap(mockDataBase.first)
        XCTAssertEqual(mockDataBase.count, 1)
        
        XCTAssertEqual(sutNote.title, testNote.title)
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, testNote.comments)
        XCTAssertEqual(sutNote.event, .accident)
        
        XCTAssertNil(sutNote.value)
        XCTAssertNil(sutNote.measure)
    }
    
    func testCreateMeasureNote() throws {
        let value = try XCTUnwrap(Double(testNote.amount))
        XCTAssertEqual(sut.notes.count, 0)
        
        try sut.createNoteUseCase.createNote(type: .measure, title: testNote.title, date: .dateTest, comments: testNote.comments, amount: testNote.amount, event: testNote.eventType, bodyPart: testNote.bodyPart)
        
        let sutNote = try XCTUnwrap(mockDataBase.first)
        XCTAssertEqual(mockDataBase.count, 1)
        XCTAssertEqual(sutNote.title, "Measure for \(testNote.bodyPart.rawValue) : \(value)")
        XCTAssertEqual(sutNote.date, .dateTest)
        XCTAssertEqual(sutNote.comments, testNote.comments)
        XCTAssertEqual(sutNote.measure, .chest)
        
        XCTAssertNil(sutNote.event)
    }
    
    
    //FETCH
    
    func testFetchAllNotes() throws {
        mockDataBase.append(.testSimple)
        
        mockDataBase = try sut.fetchAllNotesUseCase.fetchAll()
        
        XCTAssertGreaterThan(mockDataBase.count, 0)
        
    }
    
    //UPDATE
    func testUpdateNote() throws {
        let note = Note(id: .testUUID, type: .simple, title: testNote.title, value: Double(testNote.amount)!, date: .dateTest, createdAt: .dateTest, comments: testNote.comments, measure: testNote.bodyPart, event: testNote.eventType, updatedAt: nil)
        mockDataBase.append(note)
        
        let newType = ReminderType.measure
        let newEvent = EventType.estrus
        let newTitle = testNote.title + " Updated"
        let newDate = "2025-02-12T19:00:00+0100".toDate()
        let newAmount = "120.00"
        let newComments = testNote.comments + " Updated"
        let newMeasure = PetSize.length
        
        sut.updateNote(id: .testUUID, type: newType, newTitle: newTitle, newDate: newDate, newComments: newComments, newAmount: newAmount, newEvent: newEvent, newBodyPart: newMeasure)
        let noteUpdated = try XCTUnwrap(mockDataBase.first(where: { $0.id == note.id }))
        
        XCTAssertEqual(noteUpdated.type, newType)
        XCTAssertEqual(noteUpdated.title, newTitle)
        XCTAssertEqual(noteUpdated.comments, newComments)
        
    }
    
    //MARK: Delete
    
    func testRemoveNote()  throws {
        let note = Note(id: .testUUID, type: .simple, title: testNote.title, value: Double(testNote.amount)!, date: .dateTest, createdAt: .dateTest, comments: testNote.comments, measure: testNote.bodyPart, event: testNote.eventType, updatedAt: nil)
        XCTAssertEqual(sut.notes.count, 0)
        
        sut.notes.append(note)
        XCTAssertEqual(sut.notes.count, 1)
        
        sut.removeNote(id: .testUUID)
        XCTAssertEqual(sut.notes.count, 0)
    }
}
