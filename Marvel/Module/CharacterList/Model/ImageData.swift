//
//  CharacterModel.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

// MARK: - ImageData
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




