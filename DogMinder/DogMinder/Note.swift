//
//  Reminder.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import Foundation


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
    let id = UUID()
    let createdAt = Date.now
    
    var type: ReminderType
    var description: String
    var date: Date
    
    var value: Double?
    var comments: String?
    var measure: PetSize?
    var event: EventType?
    
    init(id: UUID = UUID(), type: ReminderType, description: String, value: Double? = nil, date: Date = Date.now, createdAt: Date = Date.now, comments: String? = nil, measure: PetSize?, event: EventType?) {
        self.type = type
        self.description = description
        self.value = value
        self.date = date
        self.comments = comments
        self.measure = measure
        self.event = event
    }
    
    init(simpleReminder: String, date: Date, comments: String) {
        self.type = .simple
        self.description = simpleReminder
        self.date = date
        self.comments = comments

    }
    
    init(expense: String, amount: Double, date: Date, comments: String?) {
        self.type = .expense
        self.description = expense
        self.value = amount
        self.date = date
        self.comments = comments ?? ""
  
    }
    
    init(eventType: EventType, description: String, date: Date, comments: String?) {
        self.type = .event
        self.event = eventType
        self.date = date
        self.description = description
        self.comments = comments
        
    }
    
//    init(general: String, date: Date, comments: String) {
//        self.type = .general
//        self.description = general
//        self.date = date
//        self.comments = comments
//    }
    
    init(bodyPart: PetSize, value: Double, date: Date, comments: String) {
        self.type = .measure
        self.description = "Measure for \(bodyPart.rawValue) : \(value)"
        self.value = value
        self.date = date
        self.comments = comments
    }
    
}


extension Note {
   static let examplesSimples = [Note(simpleReminder: "Vacuna",
                               date: "2024-02-05T19:00:00+0100".toDate(),
                        comments: "Vacuna contra la rabia"),
                          Note(simpleReminder: "Comprar comida",
                                date: "2024-02-08T19:00:00+0100".toDate(),
                                comments: "Pienso para perros, marca preferida"),
                          Note(simpleReminder: "Baño", date: "2024-02-12T19:00:00+0100".toDate(), comments: "Usar champú suave, cepillado")
   ]
    
}


extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self) ?? Date.now
    }
}
