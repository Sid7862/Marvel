//
//  CharacterModel.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

// MARK: - CharacterData
struct CharacterData: Codable, Equatable {
    let identifier: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: ImageData?
    let resourceURI: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case modified
        case thumbnail
        case resourceURI
    }
}



