//
//  MarvelCharacterCellView.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 31/1/24.
//

import SwiftUI

struct MarvelCharacterCellView: View {
    let character: MarvelCellCharacter
    @State var scale = 10
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Image(uiImage: character.thumbnail)
                    .clipShape(.rect(cornerRadius: 8))
                    .scaledToFill()
                    .border(Color.black.opacity(0.5))
                    .shadow(color: .white.opacity(0.5), radius: 7, x: 6, y: 6)
                
                Image(systemName: "star.fill").foregroundStyle(character.favorite ? Color.yellow.opacity(0.7) : Color.clear)
                    .scaleEffect(CGSize(width: scale, height: scale))
                    .animation(.easeIn.speed(1),value: scale)
                    .padding(1)
                    .font(.largeTitle)
                    
                    
            }
            Text(character.name.uppercased())
                .font(.headline.bold())
                .background(Color.white.blur(radius: 15))
                .onAppear {
                  scale = 1
                }
        }
    }
}

#Preview {
    ZStack{
        Image("favcharbg")
            .opacity(2)
        MarvelCharacterCellView(character: .sample)
    }
}
