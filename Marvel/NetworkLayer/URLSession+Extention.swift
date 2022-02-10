//
//  URLSession+Extention.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

enum Method: String {
    
    case GET
}

public enum APIError : Error,Equatable {
    
    case error(_ errorString : String)
}

extension URLSession
{
    func request<T:Codable>(
        url: URL?,expenting:T.Type,
        method:Method = .GET,
        body: [String : String]? = nil,
        header: [String: Any?]? = nil,
        completion:@escaping (Result<T,APIError>) -> Void) {
            
            guard let url = url else {
                completion(.failure(APIError.error("Invalid URL")))
                return
            }
            var request = URLRequest(url: url)
            
            request.timeoutInterval = 30
            
            request.httpMethod = method.rawValue
            
            if let body = body
            {
                guard let httpbody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
                else {
                    completion(.failure(.error("Error: \("Cannot encode body")")))
                    return
                }
                request.httpBody = httpbody
                let jsonInputString = String(data: httpbody, encoding: .utf8)
                print((jsonInputString ?? "") as String)
                
            }
            let task = self.dataTask(with: request) { data, response, error in
                
                if let error = error
                {
                    
                    if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet
                    {
                        // No internet
                        completion(.failure(.error("No Internet")))
                        return
                    }
                    else if let err = error as? URLError, err.code  == URLError.Code.timedOut
                    {
                        // No internet
                        completion(.failure(.error("Request time out")))
                        return
                    }
                    else{
                        
                        completion(.failure(.error("Error: \(error.localizedDescription.description)")))
                        return
                    }
                    
                }
                
                guard let response = response as? HTTPURLResponse, (200...299) .contains(response.statusCode) else
                {
                    
                    completion(.failure(.error("Error: \(String(describing: error?.localizedDescription))")))
                    return
                }
                
                guard let data = data
                else{
                    completion(.failure(.error("")))
                    return
                }
                
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                        // try to read out a string array
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                let deoder = JSONDecoder()
                
                do{
                    let decodedData = try deoder.decode(T.self, from: data)
                    if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                        print(JSONString)
                    }
                    completion(.success(decodedData))
                    return
                }
                catch let decodingError
                {
                    completion(.failure(.error("Error : \(decodingError.localizedDescription)")))
                    return
                }
                
            }
            task.resume()
        }
}
