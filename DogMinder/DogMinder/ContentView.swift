//
//  ContentView.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 8/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var showNewNote = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink {
                        NoteDetail(noteId: note.id, viewModel: viewModel)
                    } label:{
                        VStack(alignment:.leading){
                            Text(note.title)
                                .font(.headline.bold())
                            Text(note.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .navigationDestination(for: Note.self) { value in
                NoteDetail(noteId: value.id, viewModel: viewModel)
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
            NoteDetail(noteId: nil, viewModel: viewModel)
        }
        
    }
}

#Preview {
   NavigationStack {
        ContentView(viewModel: .previewViewModel)
    }
}
