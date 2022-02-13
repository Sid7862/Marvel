//
//  CharacterListAPIUnitTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import XCTest

@testable import Marvel

import Bond

import ReactiveKit

class CharacterListAPIUnitTests: XCTestCase {
    
    
    class MockCharacterListViewModel : characterListVMP
    {
        var pageInfo: PageInfo? = nil
        var status: Observable<RequestStatus?> = Observable(nil)
        var character: Observable<[CharacterData]?> = Observable(nil)
        var disposeBag: DisposeBag = DisposeBag()
        var isLoading: Observable<Bool> = Observable(false)
        func getAllCharactersWithPagination(withOffset offset: Int) {
            let timestamp = String(Date().currentTimeMillis())
            let md5String = timestamp + API.privateKey + API.publicKey
            var components = URLComponents()
            components.scheme = API.scheme
            components.host = API.baseURL
            components.path = API.getCharacter
            components.queryItems = [
                URLQueryItem(name: "limit", value: FetchLimt.twenty.rawValue),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "ts", value: timestamp),
                URLQueryItem(name: "apikey", value: API.publicKey),
                URLQueryItem(name: "hash", value: MyUtils.shared.MD5(string: md5String))
            ]
            guard let requestUrl = components.url?.absoluteURL else {return}
            isLoading.value = true
            let session = URLSession(configuration: .default)
            session.request(url: requestUrl, expenting: CharacterResponse.self, method: .GET, body: nil, header: nil) { (result: Result<CharacterResponse, APIError>) in
                self.isLoading.value = false
                switch result {
                case .success(let response):
                    guard let data = response.data else {return}
                    guard let result = data.results else {return}
                    DispatchQueue.main.async
                    {
                        self.character.value = result
                        self.pageInfo = PageInfo(offset: data.offset, limit: data.limit, total: data.total, count: data.count, results: result)
                    }
                    break
                case .failure(let Apierror):
                    switch Apierror {
                    case .error(let errorString):
                        print(errorString)
                        self.status.value = RequestStatus(success: false, message: errorString,interaction: true)
                        break
                    }
                }
            }
        }
        
    
        
    }
    
    let sut = MockCharacterListViewModel()
    
    func test_CharacterListAPIResponse_With_ValidKey()
    {
        //Arrange
        let sut = MockCharacterListViewModel()

        //Given
        let exception = self.expectation(description: "CharacterListAPIResponse_With_ValidKey")
        sut.getAllCharactersWithPagination(withOffset: 0)
        
        //Assert
        XCTAssertNotNil(sut.character)
                    
        exception.fulfill()
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
