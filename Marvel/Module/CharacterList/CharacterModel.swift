//
//  CharacterModel.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

// MARK: - CharacterResponse
struct CharacterResponse:Codable,Equatable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: PageInfo?
}
struct PageInfo: Codable, Equatable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterData]?
}

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
struct ImageData: Equatable, Codable {
    let path: String?
    let imageExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }

    init(path: String?, imageExtension: String?) {
        self.path = path
        self.imageExtension = imageExtension
    }
}




