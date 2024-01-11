//
//  ReminderTypeView.swift
//  DogMinder
//
//  Created by Adrian Iraizos Mendoza on 10/1/24.
//

import SwiftUI

struct ReminderTypeView: View {
    let name: String
    let imageName: String
    let count: Int
    let color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
            VStack(alignment:.leading) {
                    Text(name)
                    .font(.title2)
                    .padding(.bottom)
                HStack(alignment:.firstTextBaseline) {
                    Image(systemName: imageName)
                        .font(.title2)
                    Spacer()
                    Text("\(count)")
                        .font(.title.bold())
              }
            }
            .foregroundStyle(color)
            .padding(.horizontal)
            
           
        }
    }
}

#Preview {
    ReminderTypeView(name: "All", imageName: "list.bullet", count: 6, color: .teal)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .frame(width:100, height: 100)
}
