//
//  CharacterResponseTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
@testable import Marvel

class CharacterResponseTests: XCTestCase,ParsingHelper {
    typealias ParseableObjectType = CharacterResponse
    
    func test_initialzeCharacterResponse() {
        let characterResponse = BuildCharacterResponse()
        XCTAssertNotNil(characterResponse)
        XCTAssertEqual(characterResponse.code, 200)
    }
    
    func test_givenCharacterResponseFromJson_parsesExpectedValues() {
        let actual = givenParsedObjectFromJson()
        let expected = BuildCharacterResponse()
        XCTAssertEqual(actual, expected)
    }
    
    private func BuildCharacterResponse() -> CharacterResponse {
        CharacterResponse(code: 200, status: "Ok", copyright: "© 2022 MARVEL", data: nil)
    }
}
