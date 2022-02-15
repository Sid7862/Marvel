//
//  ParsingHelper.swift
//  MarvelTests
//
//  Created by Sahibuddin Ahmed on 15/02/22.
//

import Foundation

private enum ParsingHelperError: LocalizedError {
    case jsonUrlNotFound
    case dataParsingFailed
}

protocol ParsingHelper {
    associatedtype ParseableObjectType: Decodable, Equatable
    func givenParsedObjectFromJson() -> ParseableObjectType
}

extension ParsingHelper where Self: AnyObject {
    func givenParsedObjectFromJson() -> ParseableObjectType {
        try! parseObjectFromJson()
    }

    private func parseObjectFromJson() throws -> ParseableObjectType {
        guard let url = urlForJsonFile() else { throw ParsingHelperError.jsonUrlNotFound }
        guard let model = decodeObject(fromJsonAt: url) else { throw ParsingTesterError.dataParsingFailed }
        return model
    }

    private func urlForJsonFile() -> URL? {
        Bundle(for: Self.self).url(forResource: String(describing: ParseableObjectType.self), withExtension: "json")
    }

    private func decodeObject(fromJsonAt url: URL) -> ParseableObjectType? {
        let decoder = JSONDecoder()
        return try? decoder.decode(ParseableObjectType.self, from: Data(contentsOf: url))
    }
}
