//
//  Character.swift
//  RickAndMortyExplorerApp
//
//  Created by imac10 on 17/12/2025.
//

import Foundation
struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    
    let origin: Origin
    let location: LocationInfo
    
    struct Origin: Codable {
        let name : String
    }
    
    struct LocationInfo: Codable {
        let name: String
    }
}
