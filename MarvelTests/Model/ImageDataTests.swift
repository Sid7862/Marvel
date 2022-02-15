//
//  ImageDataTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
@testable import Marvel

class ImageDataTests: XCTestCase,ParsingHelper {
    typealias ParseableObjectType = ImageData
    
    func test_givenImageDataFromJson_parsesExpectedValues() {
        let actual = givenParsedObjectFromJson()
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
}

