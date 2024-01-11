//
//  ReminderTypeGrid.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 11/1/24.
//

import SwiftUI

struct ReminderTypeGridView: View {
    var viewModel: ViewModel
    var grid = [GridItem(),GridItem()]
    var body: some View {
        LazyHGrid(rows: grid) {
            Button {
                viewModel.noteFilter = nil
            } label: {
                ReminderTypeView(name: "All", imageName: "list.bullet", count: viewModel.notes.count, color: .black)
            }
            ForEach(ReminderType.allCases) { reminder in
                Button {
                    viewModel.noteFilter = reminder
                }
            label: {
                ReminderTypeView(name: reminder.rawValue.firstUppercased, imageName: reminder.imageName, count: viewModel.countNotes(for: reminder), color: reminder.color)
            }
            }
        }
        .background(Color.gray.quinary.opacity(0.1))
    }
}


#Preview {
    ReminderTypeGridView(viewModel: ViewModel())
}
