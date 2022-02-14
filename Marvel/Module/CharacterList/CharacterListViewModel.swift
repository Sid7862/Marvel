//
//  CharacterListVM.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation
import Bond
import ReactiveKit

protocol characterListViewModelProtocol {
    var character :Observable<[CharacterData]?> {get set}
    var disposeBag : DisposeBag {get}
    var isLoading : Observable<Bool> {get set} //check if mostview is loading
    var status: Observable<RequestStatus?> {get set}
    var pageInfo: PageInfo? {get set}
    
    func getAllCharactersWithPagination(withOffset offset:Int)
}

class characterListViewModel : characterListViewModelProtocol {
    var pageInfo: PageInfo? = nil
    var status: Observable<RequestStatus?> = Observable(nil)
    var character: Observable<[CharacterData]?> = Observable(nil)
    var disposeBag: DisposeBag = DisposeBag()
    var isLoading: Observable<Bool> = Observable(false)
    
    func getAllCharactersWithPagination(withOffset offset:Int) {
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
                DispatchQueue.main.async {
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
