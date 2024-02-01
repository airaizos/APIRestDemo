//
//  MarvelCharacterCellView.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import SwiftUI

struct MarvelCharacterCellView: View {
    let character: MarvelCellCharacter
    var body: some View {
        ZStack{
        VStack {
                Image(uiImage: character.thumbnail)
                .clipShape(.rect(cornerRadius: 8))
                Text(character.name.uppercased())
                    .font(.headline.bold())
            }
        }
    }
}

#Preview {
    MarvelCharacterCellView(character: .sample)
}
