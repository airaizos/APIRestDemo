//
//  PersistenceProtocol.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 9/1/24.
//

import Foundation

protocol PersistenceProtocol {
    func fetchAll() throws -> [Note]
    func insert(note: Note) throws
    func update(id: UUID, type: ReminderType, newDescription: String, newDate: Date, newComments: String, newAmount: String, newEvent:EventType, newBodyPart: PetSize) throws
    func delete(id:UUID) throws
    
}
