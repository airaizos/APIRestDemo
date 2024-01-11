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
            VStack {
                ReminderTypeGrid(viewModel: viewModel)
                NoteListView(viewModel: viewModel)
            }
            .background(.fill)
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
