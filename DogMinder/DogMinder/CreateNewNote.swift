//
//  CreateNewNote.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI

struct CreateNewNote: View {
    @Environment(\.dismiss) private var dismiss
    

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
                Picker("Tipo", selection: $noteType) {
                    ForEach(ReminderType.allCases) { type in
                        Text(type.rawValue.firstUppercased)
                    }
                }
                .pickerStyle(.segmented)
                
                Group {
                    Text(noteType.rawValue.firstUppercased)
                        .font(.title)
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
                    Button("Save") {
                        viewModel.saveNote(type: noteType, description: description, date: date, comments: comments, amount: amount, event: eventType, bodyPart: bodyPart)
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("New Note")
        .navigationBarTitleDisplayMode(.large)
        
       
    }
}

#Preview {
    NavigationStack{
        CreateNewNote(viewModel: ViewModel())
    }
}
