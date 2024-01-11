//
//  Reminder.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI
import CoreData



enum ReminderType: String,CaseIterable,Identifiable {
    case simple = "simple", expense = "expense", event = "event", measure = "measure"
    
    var id: Self {
        self
    }
}

enum EventType: String, CaseIterable, Identifiable {
    case estrus = "estrus", emergency = "emergency", accident = "accident", operation = "operation", treatment = "treatment"
    
    var id: Self { self }
}

enum PetSize: String, CaseIterable, Identifiable {
     case weight = "weight", neck = "neck", chest = "chest", length = "length", waist = "waist", height = "height"
    var id: Self { self }
}

struct Note: Identifiable, Hashable {
    let id: UUID
    let createdAt: Date
    
    var type: ReminderType
    var title: String
    var date: Date
    
    var value: Double?
    var comments: String?
    var measure: PetSize?
    var event: EventType?
    var updatedAt: Date?
    
    init(id: UUID = UUID(), type: ReminderType, title: String, value: Double? = nil, date: Date = Date.now, createdAt: Date = Date.now, comments: String? = nil, measure: PetSize?, event: EventType?, updatedAt: Date? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.type = type
        self.title = title
        self.value = value
        self.date = date
        self.comments = comments
        self.measure = measure
        self.event = event
        self.updatedAt = updatedAt
    }
    
    ///SIMPLE
    init(simpleReminder: String, date: Date, comments: String) {
        self.id = UUID()
        self.createdAt = Date.now
        self.type = .simple
        self.title = simpleReminder
        self.date = date
        self.comments = comments

    }
    
    ///EXPENSE
    init(expense: String, amount: Double, date: Date, comments: String?) {
        self.id = UUID()
        self.createdAt = Date.now
        self.type = .expense
        self.title = expense
        self.value = amount
        self.date = date
        self.comments = comments ?? ""
  
    }
    
    ///EVENT
    init(eventType: EventType, title: String, date: Date, comments: String?) {
        self.id = UUID()
        self.createdAt = Date.now
        self.type = .event
        self.event = eventType
        self.date = date
        self.title = title
        self.comments = comments
        
    }
    
    ///BODYPART
    init(bodyPart: PetSize, value: Double, date: Date, comments: String) {
        self.id = UUID()
        self.createdAt = Date.now
        self.type = .measure
        self.measure = bodyPart
        self.title = "Measure for \(bodyPart.rawValue) : \(value)"
        self.value = value
        self.date = date
        self.comments = comments
    }
    
}

//MARK: Examples
extension Note {
   static let examplesSimples = [Note(simpleReminder: "Vacuna",
                               date: "2024-02-05T19:00:00+0100".toDate(),
                        comments: "Vacuna contra la rabia"),
                          Note(simpleReminder: "Comprar comida",
                                date: "2024-02-08T19:00:00+0100".toDate(),
                                comments: "Pienso para perros, marca preferida"),
                          Note(simpleReminder: "Baño", date: "2024-02-12T19:00:00+0100".toDate(), comments: "Usar champú suave, cepillado")
   ]
    
    static let testSimple = Note(simpleReminder: "Simple Test", date: .dateTest, comments: "Comments")
    static let testExpense = Note(expense: "Comida", amount: 100.00, date: .dateTest, comments: "Comments")
    static let testEvent = Note(eventType: .accident, title: "Caida", date: .dateTest, comments: "Comments")
    static let testMeasure = Note(bodyPart: .weight, value: 10.00, date: .dateTest, comments: "Comments")
}


// Extensions for Views
extension ReminderType {
    var imageName: String {
        switch self {
        case .simple: "note.text"
        case .expense: "banknote"
        case .event: "calendar.badge.exclamationmark"
        case .measure: "ruler"
        }
    }
    
    var color: Color {
        switch self {
        case .simple: Color.orange
        case .expense: Color.indigo
        case .event: Color.teal
        case .measure: Color.mint
        }
    }
}

extension Note {
    var valueView: String {
        value != nil ? "\(value ?? 0)" : ""
    }
    
    var commentsView:String {
        comments ?? ""
    }
    var measureView: String {
        measure?.rawValue.firstUppercased ?? ""
    }
    
    var eventTypeView: String {
        event?.rawValue.firstUppercased ?? ""
    }
    
    var updatedView: String {
        updatedAt?.formatted(date: .abbreviated, time: .shortened) ?? ""
    }
    var createdView:String {
        createdAt.formatted(date: .abbreviated, time: .shortened)
    }
    
    var dateView: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
}
