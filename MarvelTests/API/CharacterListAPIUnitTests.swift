//
//  CharacterListAPIUnitTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import XCTest
import Bond
import ReactiveKit
@testable import Marvel

class CharacterListAPIUnitTests: XCTestCase {
    
    func test_CharacterListAPIResponse_With_ValidKey() {
        var character : [CharacterData]? = nil
        let exception = self.expectation(description: "CharacterListAPIResponse_With_ValidKey")
        
        let timestamp = String(Date().currentTimeMillis())
        let md5String = timestamp + API.privateKey + API.publicKey
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.baseURL
        components.path = API.getCharacter
        components.queryItems = [
            URLQueryItem(name: "limit", value: FetchLimt.twenty.rawValue),
            URLQueryItem(name: "offset", value: "\(20)"),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: API.publicKey),
            URLQueryItem(name: "hash", value: MyUtils.shared.MD5(string: md5String))
        ]
        guard let mockRequestUrl = components.url?.absoluteURL else {return}
        let mockURLSession = URLSession(configuration: .default)
        mockURLSession.request(url: mockRequestUrl, expenting: CharacterResponse.self, method: .GET, body: nil, header: nil) { (result: Result<CharacterResponse, APIError>) in
            switch result {
            case .success(let response):
                guard let data = response.data else {return}
                guard let result = data.results else {return}
                DispatchQueue.main.async {
                    result.count>0 ? character = result : nil
                    exception.fulfill()
                }
                break
            case .failure(let Apierror):
                switch Apierror {
                case .error(let errorString):
                    print(errorString)
                    exception.fulfill()
                    break
                }
            }
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(character)
            XCTAssertGreaterThan(character?.count ?? 0, 0)
        }
        XCTAssertEqual(components.host, "gateway.marvel.com")
    }
}

