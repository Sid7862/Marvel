//
//  CharacterDetail.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 17/02/22.
//

import Foundation

struct CharacterDetail
{
    let identifier: Int
    let name: String
    let description: String
    let imageURL: URL?

    init(identifier: Int, name: String, description: String, imageURL: URL? = nil) {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.imageURL = imageURL
    }
}
