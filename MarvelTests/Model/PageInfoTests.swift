//
//  PageInfoTests.swift
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


class PageInfoTests: XCTestCase {
    
    func test_givenPageInfoFromJson_parsesExpectedValues()
    {
        let actual = BuildPageInfoFromJson()
        let expected = BuildPageInfo()
        XCTAssertEqual(actual, expected)
    }
    
    private func BuildPageInfo() -> PageInfo {
        let pageInfo = PageInfo(
            offset: 0,
            limit: 20,
            total: 1559,
            count: 20,
            results: nil
        )
        return pageInfo
    }
    
    private func BuildPageInfoFromJson() -> PageInfo {
        try! parseObjectFromJson()
    }
    
    private func parseObjectFromJson() throws -> PageInfo {
        guard let url = urlForJsonFile() else { throw ParsingTesterError.jsonUrlNotFound }
        guard let model = decodeObject(fromJsonAt: url) else { throw ParsingTesterError.dataParsingFailed }
        return model
    }
    
    private func urlForJsonFile() -> URL? {
        Bundle(for: Self.self).url(forResource: String(describing: PageInfo.self), withExtension: "json")
    }
    
    private func decodeObject(fromJsonAt url: URL) -> PageInfo? {
        let decoder = JSONDecoder()
        return try? decoder.decode(PageInfo.self, from: Data(contentsOf: url))
    }
    
}
