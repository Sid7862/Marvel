//
//  AppModel+EnumTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
@testable import Marvel

class AppModel_EnumTests: XCTestCase {
    
    func test_initializeValidFetchLimit() {
        let twenty = FetchLimt.twenty.rawValue
        XCTAssertNotNil(twenty)
        XCTAssertEqual(twenty, "20")
    }
    
    func test_initializeRequestStatus() {
        let requestStatus = RequestStatus(
            success: true,
            message: "Successfull",
            interaction: false
        )
        XCTAssertNotNil(requestStatus)
        XCTAssertEqual(requestStatus.message, "Successfull")
        XCTAssertEqual(requestStatus.success, true)
        XCTAssertEqual(requestStatus.interaction, false)
    }
    
}
