//
//  NetworkManager.swift
//  RickAndMortyExplorerApp
//
//  Created by imac10 on 17/12/2025.
//

import Foundation
final class NetworkManager {
    static let shared = NetworkManager()
    private init () {}
    
    private let baseURL = URL(string:"https://rickandmortyapi.com/api")!
    
    func fetchCharacters() async throws -> [Character] {
        let url = baseURL.appendingPathComponent("character")
        let (data, response) = try await URLSession.shared.data(from:url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
}
