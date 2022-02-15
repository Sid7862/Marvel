//
//  PageInfoTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
@testable import Marvel

class PageInfoTests: XCTestCase,ParsingHelper {
    typealias ParseableObjectType = PageInfo
    
    func test_initialzePageInfo() {
        let pageInfo = BuildPageInfo()
        XCTAssertNotNil(pageInfo)
        XCTAssertEqual(pageInfo.total, 1559)
    }

    func test_givenPageInfoFromJson_parsesExpectedValues() {
        let actual = givenParsedObjectFromJson()
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
}
