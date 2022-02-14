//
//  ImageDataTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

@testable import Marvel
import XCTest

private enum ParsingTesterError: LocalizedError {
    case jsonUrlNotFound
    case dataParsingFailed
}

class ImageDataTests: XCTestCase {
    
    func test_givenImageDataFromJson_parsesExpectedValues() {
        let actual = BuildCharacterDataFromJson()
        let expected = BuildImageData()
        XCTAssertEqual(actual, expected)
    }
    
    func test_initialzeImageData() {
       let imageData = ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", imageExtension: "jpg")
        XCTAssertNotNil(imageData)
        XCTAssertEqual(imageData.imageExtension, "jpg")
    }
    
    private func BuildImageData() -> ImageData {
        let imageData = ImageData(
            path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
            imageExtension: "jpg"
        )
        return imageData
    }
    
    private func BuildCharacterDataFromJson() -> ImageData {
        try! parseObjectFromJson()
    }
    
    private func parseObjectFromJson() throws -> ImageData {
        guard let url = urlForJsonFile() else { throw ParsingTesterError.jsonUrlNotFound }
        guard let model = decodeObject(fromJsonAt: url) else { throw ParsingTesterError.dataParsingFailed }
        return model
    }
    
    private func urlForJsonFile() -> URL? {
        Bundle(for: Self.self).url(forResource: String(describing: ImageData.self), withExtension: "json")
    }
    
    private func decodeObject(fromJsonAt url: URL) -> ImageData? {
        let decoder = JSONDecoder()
        return try? decoder.decode(ImageData.self, from: Data(contentsOf: url))
    }
}

