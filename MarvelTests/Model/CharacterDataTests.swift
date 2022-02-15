//
//  CharacterDataTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import XCTest
@testable import Marvel

enum ParsingTesterError: LocalizedError {
    case jsonUrlNotFound
    case dataParsingFailed
}

class CharacterDataTests: XCTestCase,ParsingHelper {
    typealias ParseableObjectType = CharacterData
    
    func test_initialzeCharacterData() {
        let characterData = BuildCharacterData()
        XCTAssertNotNil(characterData)
        XCTAssertEqual(characterData.identifier, 1017100)
    }
    
    func test_givenCharacterDataFromJson_parsesExpectedValues() {
        let actual = givenParsedObjectFromJson()
        let expected = BuildCharacterData()
        XCTAssertEqual(actual, expected)
    }
    
    private func BuildImageData() -> ImageData {
        let imageData = ImageData(
            path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
            imageExtension: "jpg"
        )
        return imageData
    }
    
    private func BuildCharacterData() -> CharacterData {
        let characterData = CharacterData(
            identifier: 1017100,
            name: "A-Bomb (HAS)",
            description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
            modified: "2013-09-18T15:54:04-0400",
            thumbnail: BuildImageData(),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100"
        )
        return characterData
    }
    
}
