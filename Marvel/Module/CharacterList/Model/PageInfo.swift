//
//  CharacterModel.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

// MARK: - PageInfo
struct PageInfo: Codable, Equatable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterData]?
}




