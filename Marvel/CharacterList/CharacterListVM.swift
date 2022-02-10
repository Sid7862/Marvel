//
//  CharacterListVM.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

protocol characterListVMP
{
    
    func getAllCharacters(completion:@escaping ([CharacterData]) -> Void)
    
}
class characterListVM : characterListVMP
{
    func getAllCharacters(completion:@escaping (Result<CharacterResponse,APIError>) -> Void) {
        
        let timestamp = String(Date().currentTimeMillis())
        let md5String = timestamp + "2e9a621f6937c8258369130fdc075a23793f15b0" + "c70bc8b5efd652fdd35013876f661cd5"
        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=c70bc8b5efd652fdd35013876f661cd5&hash=\(MyUtils.shared.MD5(string: md5String))"
        let session = URLSession(configuration: .default)
        session.request(url: URL(string: urlString)!, expenting: CharacterResponse.self, method: .GET, body: nil, header: nil) { (result: Result<CharacterResponse, APIError>) in
            completion(result)
            
        }
    }
    
}
