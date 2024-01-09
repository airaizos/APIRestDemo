//
//  ContentView.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    @State var showNewNote = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    VStack(alignment:.leading){
                        Text(note.description)
                            .font(.headline.bold())
                        Text(note.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                }
            }
           
          
        }
        .navigationTitle("DogMinder")
        .toolbar {
            ToolbarItem(placement: .status) {
                Button {
                    showNewNote.toggle()
                } label: {
                    Label("New Note", systemImage: "plus")
                        .labelStyle(.titleAndIcon)
                }
                
            }
        }
        .fullScreenCover(isPresented: $showNewNote) {
            CreateNewNote(viewModel: viewModel)
          
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(viewModel: ViewModel(reminders: Note.examplesSimples))
    }
}
