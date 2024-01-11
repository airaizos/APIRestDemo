//
//  ListCellNoteView.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 11/1/24.
//

import SwiftUI

struct ListCellNoteView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                switch note.type {
                case .expense:
                    HStack {
                        Text(note.title)
                        Spacer()
                        Text(note.valueView)
                    }
                    .font(.headline)
                    .foregroundStyle(note.type.color)
                    .blendMode(.luminosity)
                case .event:
                    Text(note.eventTypeView)
                        .font(.headline)
                        .blendMode(.luminosity)
                case .measure:
                    HStack {
                        Text(note.measureView)
                            
                        Spacer()
                        Text(note.valueView)
                    }
                    .font(.headline)
                    .blendMode(.luminosity)
                case .simple:
                    Text(note.title)
                    
                }
            }
            Text(note.dateView)
                .font(.subheadline)
        }
        .foregroundStyle(note.type.color)
    }
}

#Preview {
    return VStack{
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, style: .init(lineWidth: 1))
                .foregroundStyle(.white)
            ListCellNoteView(note: .testMeasure)
        }
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, style: .init(lineWidth: 1))
                .foregroundStyle(.white)
            ListCellNoteView(note: .testEvent)
        }
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, style: .init(lineWidth: 1))
                .foregroundStyle(.white)
            ListCellNoteView(note: .testSimple)
        }
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, style: .init(lineWidth: 1))
                .foregroundStyle(.white)
            ListCellNoteView(note: .testExpense)
        }
    }
    .padding(.horizontal)
}
