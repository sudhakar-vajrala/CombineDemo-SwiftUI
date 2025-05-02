//
//  APIService.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchUsers(skipToken: String? = nil) -> AnyPublisher<PaginatedResponse, Error> {
        var components = URLComponents(string: "https://reqres.in/api/users")!
        if let token = skipToken {
            components.queryItems = [URLQueryItem(name: "page", value: token)]
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PaginatedResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    func fetchData<T: Decodable>(_ urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
                    return Fail(error: URLError(.badURL))
                        .eraseToAnyPublisher()
                }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
