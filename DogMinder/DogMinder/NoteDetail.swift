//
//  CreateNewNote.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI

struct NoteDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    let noteId: UUID?
    var viewModel: ViewModel
    @State var noteType: ReminderType = .simple
    
    @State var comments: String = ""
    @State var description: String = ""
    @State var date: Date = Date.now
    @State var amount: String = "0"
    
    @State var eventType: EventType = .treatment
    @State var bodyPart: PetSize = .weight
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment:.leading) {
                Text(noteId == nil ? "New \(noteType.rawValue.firstUppercased) Note" : "Edit Note")
                    .font(.largeTitle.bold())
                    .foregroundStyle(noteType.color)
                Picker("Tipo", selection: $noteType) {
                    ForEach(ReminderType.allCases) { type in
                        Text(type.rawValue.firstUppercased)
                    }
                }
                .pickerStyle(.segmented)
                
                Group {
                    switch noteType {
                    case .simple: Text("")
                    case .expense:
                        HStack{
                            Text("Amount")
                            TextField("Amount", text: $amount, prompt: Text("Amount"))
                                .lineLimit(1)
                                .keyboardType(.decimalPad)
                        }
                    case .event:
                        HStack {
                            Text("Event")
                            Picker("Event", selection: $eventType) {
                                ForEach(EventType.allCases) { type in
                                    Text(type.rawValue.firstUppercased).tag(type)
                                }
                            }
                        }
                    case .measure:
                        HStack {
                            Text("BodyPart:")
                            Picker("Event", selection: $bodyPart) {
                                ForEach(PetSize.allCases) { type in
                                    Text(type.rawValue.firstUppercased).tag(type)
                                }
                            }
                        }
                        HStack {
                            Text("Amount:")
                            TextField("Amount", text: $amount, prompt: Text("Amount"))
                        }
                    }
                }
                Spacer()
                VStack(alignment:.leading){
                    Text("Description")
                    TextField("", text: $description, prompt: Text("Description"),axis: .vertical)
                }
                DatePicker("Date", selection: $date)
                VStack(alignment:.leading){
                    Text("Comments")
                    TextField("Comments", text: $comments, prompt: Text("Comments"),axis: .vertical)
                        .lineLimit(10,reservesSpace: true)
                }
            }
            
            .textFieldStyle(.roundedBorder)
            .font(.headline.bold())
            .foregroundStyle(.gray)
            .padding()
            .background(.fill.quinary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(noteId == nil ? "Save" : "Update") {
                        if let noteId {
                            viewModel.updateNote(id: noteId, type: noteType, newTitle: description, newDate: date, newComments: comments, newAmount: amount, newEvent: eventType, newBodyPart: bodyPart)
                        } else {
                            viewModel.saveNote(type: noteType, title: description, date: date, comments: comments, amount: amount, event: eventType, bodyPart: bodyPart)
                        }
                        dismiss()
                    }
                }
                
                if noteId != nil{
                    ToolbarItem(placement: .status) {
                        Button("Delete") {
                            if let noteId {
                                viewModel.removeNote(id: noteId)
                            }
                            dismiss()
                        }
                        .foregroundStyle(Color.red)
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
        .navigationTitle(noteId == nil ? "New Note" : "Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .onAppear {
                editNote()
            }
        }
    
        
    private func editNote() {
        guard let noteId, let editNote = viewModel.notes.first(where: { $0.id == noteId }) else { return }
    
        noteType = editNote.type
        comments = editNote.comments ?? ""
        description = editNote.title
        date = editNote.date
        amount = "\(editNote.value ?? 0)"
        eventType = editNote.event ?? .treatment
        bodyPart = editNote.measure ?? .weight

    }
}

#Preview {
    NavigationStack{
        NoteDetail(noteId: nil, viewModel: ViewModel())
    }
}
