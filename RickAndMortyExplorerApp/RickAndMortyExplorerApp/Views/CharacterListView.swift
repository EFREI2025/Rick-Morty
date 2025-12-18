//
//  CharacterListView.swift
//  RickAndMortyExplorerApp
//
//  Created by imac10 on 17/12/2025.
//

import SwiftUI

struct CharacterListView: View {
    let character : Character
    @State private var isFavorite = false
    var body: some View {
        ScrollView {
            VStack(spacing:16) {
                AsyncImage(url: URL(string: character.image)){
                    image in image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView ()
                }
                .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.1))
                Text(character.name).font(.largeTitle).bold()
                Text("\(character.status) \(character.species) \(character.gender)").font(.subheadline).foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 8){
                    Text("Origine:\(character.origin.name)")
                    Text("Derniére localisation: \(character.location.name)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Button {
                    isFavorite.toggle()
                }label: {
                    Label(isFavorite ? "Retirer des favoris" : "Ajouter aux favoris", systemImage: isFavorite ? "heart.fill" : "heart").padding()
                        .frame(maxWidth: .infinity).background(isFavorite ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Rick & Morty")
        .toolbar {
            NavigationLink {
                FeedbackFormView()
            } label: {
                Image(systemName: "square.and.pencil")
            }
        }

        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CharacterListView( character: Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        gender: "Male",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        origin: .init(name: "Earth"),
        location: .init(name: "Citadel of Ricks")
    ))
}
