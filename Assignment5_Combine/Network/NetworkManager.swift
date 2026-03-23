//
//  Network.swift
//  Assignment5_Combine
//
//  Created by Malik Muhammad on 3/23/26.
//

import Foundation
import Combine

protocol Network {
    func getInfo<T: Decodable>(urlString: String, modelType: T.Type) -> AnyPublisher<T, Error>
}

struct NetworkManager {
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager : Network {
    func getInfo<T>(urlString: String, modelType: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidUrl).eraseToAnyPublisher()
        }
        
        return self.urlSession.dataTaskPublisher(for: url)
            .tryMap { (data, response1) in
                guard let response = response1 as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard(200...299).contains(response.statusCode) else {
                    throw APIError.invalidResponseCode
                }
                
                return data
            }.decode(type: modelType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
