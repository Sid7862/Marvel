//
//  CharacterDetailAPIUnitTests.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 14/02/22.
//

import XCTest
import Bond
import ReactiveKit
@testable import Marvel

class CharacterDetailAPIUnitTests: XCTestCase {
    
    func test_CharacterDetailAPIResponse_With_ValidKey() {
        var character : CharacterData? = nil
        let exception = self.expectation(description: "CharacterDetailAPIResponse_With_ValidKey")
        
        let timestamp = String(Date().currentTimeMillis())
        let md5String = timestamp + API.privateKey + API.publicKey
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.baseURL
        components.path = API.getCharacter + "/" +  "1017100"
        components.queryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: API.publicKey),
            URLQueryItem(name: "hash", value: MyUtils.shared.MD5(string: md5String))
        ]
        guard let requestUrl = components.url?.absoluteURL else {return}
        let session = URLSession(configuration: .default)
        session.request(url: requestUrl, expenting: CharacterResponse.self, method: .GET, body: nil, header: nil) { (result: Result<CharacterResponse, APIError>) in
            switch result {
            case .success(let response):
                guard let data = response.data else {return}
                guard let result = data.results else {return}
                DispatchQueue.main.async {
                    result.count>0 ? character = result[0] : nil
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
            XCTAssertEqual(character?.identifier ?? 0, 1017100)
        }
    }
}
