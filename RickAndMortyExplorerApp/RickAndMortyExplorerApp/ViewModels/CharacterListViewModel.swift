//
//  CharacterListViewModel.swift
//  RickAndMortyExplorerApp
//
//  Created by imac10 on 17/12/2025.
//

import Foundation
 @MainActor
final class CharacterListViewModel: ObservableObject {
    @Published var characters : [Character] = []
    @Published var searchText : String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var filteredCharacters : [Character] {
        if searchText.isEmpty {
            return characters
        }
        return characters.filter{
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    func fetchCharacters() async {
        isLoading = true
        errorMessage = nil
        do {
            characters = try await NetworkManager.shared.fetchCharacters()}catch{
                errorMessage = "Erreur de chargment : \(error.localizedDescription)"
            }
        
        isLoading = false
    }
}
                                
