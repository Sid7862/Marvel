//
//  CharacterResponseTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
@testable import Marvel

private enum ParsingTesterError: LocalizedError {
    case jsonUrlNotFound
    case dataParsingFailed
}

class CharacterResponseTests: XCTestCase {
    
    func test_givenCharacterResponseFromJson_parsesExpectedValues() {
        let actual = BuildCharacterResponseFromJson()
        let expected = BuildCharacterResponse()
        XCTAssertEqual(actual, expected)
    }
    
    private func BuildCharacterResponse() -> CharacterResponse {
        CharacterResponse(code: 200, status: "Ok", copyright: "© 2022 MARVEL", data: nil)
    }
    
    private func BuildCharacterResponseFromJson() -> CharacterResponse {
        try! parseObjectFromJson()
    }
    
    private func parseObjectFromJson() throws -> CharacterResponse {
        guard let url = urlForJsonFile() else { throw ParsingTesterError.jsonUrlNotFound }
        guard let model = decodeObject(fromJsonAt: url) else { throw ParsingTesterError.dataParsingFailed }
        return model
    }
    
    private func urlForJsonFile() -> URL? {
        Bundle(for: Self.self).url(forResource: String(describing: CharacterResponse.self), withExtension: "json")
    }
    
    private func decodeObject(fromJsonAt url: URL) -> CharacterResponse? {
        let decoder = JSONDecoder()
        return try? decoder.decode(CharacterResponse.self, from: Data(contentsOf: url))
    }
    
}
