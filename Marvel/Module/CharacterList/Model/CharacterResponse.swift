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




