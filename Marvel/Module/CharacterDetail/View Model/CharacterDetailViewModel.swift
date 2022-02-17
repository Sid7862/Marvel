//
//  CharacterDetailVM.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import Foundation
import ReactiveKit
import Bond

protocol CharacterDetailViewModelProtocol {
    var character :Observable<CharacterDetail?> {get set}
    var disposeBag : DisposeBag {get}
    var isLoading : Observable<Bool> {get set}
    var status: Observable<RequestStatus?> {get set}
    var characterID: Int? { get set}
    
    func getCharacterDetail()
    func prepareCharacterDetail(character : CharacterData?) -> CharacterDetail?
    func prepareImageURL(imageData: ImageData?) -> URL?
}

class CharacterDetailViewModel : CharacterDetailViewModelProtocol {
    var characterID: Int? = nil
    var status: Observable<RequestStatus?> = Observable(nil)
    var character: Observable<CharacterDetail?> = Observable(nil)
    var disposeBag: DisposeBag = DisposeBag()
    var isLoading: Observable<Bool> = Observable(false)
    
    func getCharacterDetail() {
        let timestamp = String(Date().currentTimeMillis())
        let md5String = timestamp + API.privateKey + API.publicKey
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.baseURL
        components.path = API.getCharacter + "/" +  "\(characterID ?? 0)"
        components.queryItems = [
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
                    result.count>0 ? self.character.value = self.prepareCharacterDetail(character: result[0]) : nil
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
    
    func prepareCharacterDetail(character : CharacterData?) -> CharacterDetail? {
        guard let data = character,
              let identifier = data.identifier,
              let name = data.name,
              let description = data.description
        else {return nil}
        let imageURL = prepareImageURL(imageData: data.thumbnail)
        return CharacterDetail(identifier: identifier, name: name, description: description, imageURL: imageURL)
    }
    
    func prepareImageURL(imageData: ImageData?) -> URL? {
        guard let path = imageData?.path,
              let extention = imageData?.imageExtension
        else { return nil }
        return URL(string: path + "." + extention)
    }
}
