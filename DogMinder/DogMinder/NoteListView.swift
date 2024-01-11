//
//  NoteListView.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 11/1/24.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        List {
            ForEach(viewModel.filteredNotes) { note in
                NavigationLink {
                    NoteDetail(noteId: note.id, viewModel: viewModel)
                } label:{
                    ListCellNoteView(note: note)
                }
            }
        }
        .navigationDestination(for: Note.self) { value in
            NoteDetail(noteId: value.id, viewModel: viewModel)
        }
    }
}

#Preview {
    NoteListView(viewModel: ViewModel())
}
