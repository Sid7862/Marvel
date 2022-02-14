//
//  MyUtilsTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
@testable import Marvel

class MyUtilsTests: XCTestCase {
        
    func test_validStringToMD5() {
        let testString = "01234"
        let md5String = MyUtils.shared.MD5(string: testString)
        XCTAssertNotNil(md5String)
        XCTAssertEqual(md5String, "4100c4d44da9177247e44a5fc1546778")
    }
}
