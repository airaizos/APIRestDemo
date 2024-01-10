//
//  NoteEntityExtensions.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation



extension NoteEntity {
    func getNote() -> Note {
        Note(id: id ?? UUID(), type: ReminderType(rawValue: reminderType ?? "") ?? .simple, title: title ?? "", value: value, date: date ?? Date.now, createdAt: createdAt ?? Date.now, comments: comments ?? "", measure: PetSize(rawValue: measure ?? ""), event: EventType(rawValue: event ?? ""), updatedAt: updatedAt ?? Date.now)
    }
}
