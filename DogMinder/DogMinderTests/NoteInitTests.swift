//
//  DogMinderTests.swift
//  DogMinderTests
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import XCTest

@testable import DogMinder
final class NoteInitTests: XCTestCase {
   
    func testNoteSimpleInit() {
        let simpleNote = Note(simpleReminder: "Simple Test", date: .dateTest, comments: "Comments")
        
        XCTAssertEqual(simpleNote.comments, "Comments")
        XCTAssertEqual(simpleNote.date, .dateTest)
        XCTAssertEqual(simpleNote.title, "Simple Test")
    }
    
    func testNoteExpenseInit() {
        let expenseNote = Note(expense: "Comida", amount: 100.0, date: .dateTest, comments: "Comments")
        XCTAssertEqual(expenseNote.title, "Comida")
        XCTAssertEqual(expenseNote.date, .dateTest)
        XCTAssertEqual(expenseNote.value, 100.0)
        XCTAssertEqual(expenseNote.comments, "Comments")
    }

    func testNoteEventInit() {
        let eventNote = Note(eventType: .accident, title: "Caida", date: .dateTest, comments: "Comments")
        XCTAssertEqual(eventNote.type,.event)
        XCTAssertEqual(eventNote.event, .accident)
        XCTAssertEqual(eventNote.title, "Caida")
        XCTAssertEqual(eventNote.date, .dateTest)
        XCTAssertEqual(eventNote.comments, "Comments")
    }
    
    func testNoteBodyPartInit() {
        let measureNote = Note(bodyPart: .waist, value: 30.0, date: .dateTest, comments: "Comments")
        XCTAssertEqual(measureNote.type,.measure)
        XCTAssertEqual(measureNote.measure, .waist)
        XCTAssertEqual(measureNote.value,30.0)
        XCTAssertEqual(measureNote.date,.dateTest)
        XCTAssertEqual(measureNote.comments, "Comments")
    }
    
}
