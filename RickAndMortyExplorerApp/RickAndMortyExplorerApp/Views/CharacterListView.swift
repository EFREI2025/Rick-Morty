//
//  CharacterListView.swift
//  RickAndMortyExplorerApp
//
//  Created by imac10 on 17/12/2025.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Rechercher un personnage",text: $viewModel.searchText).textFieldStyle(.roundedBorder).padding()
                if viewModel.isLoading {
                    ProgressView("Chargement...")
                }else if let error = viewModel.errorMessage{
                    Text(error).foregroundColor(.red)}
                else {
                    List(viewModel.filteredCharacters){
                        character in NavigationLink {
                            CharacterDetailView(character: character)
                        }label: {
                            HStack {
                                AsyncImage(url:URL(string:character.image)){
                                    image in image.resizable()
                                }
                            placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 60, height:60)
                            .clipShape(RoundedRectangle(cornerRadius:8))
                                VStack(alignment:.leading){
                                    Text(character.name).font(.headline)
                                    Text("\(character.status) \(character.species)").font(.subheadline).foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                }
            .navigationTitle("Rick & Morty").task {
                await viewModel.fetchCharacters()
            }
            }
        }
    }
