//
//  APIEndpoint.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//

struct APIEndpoint {
    static let baseURL = "https://reqres.in/api"
    
    enum User{
        static var list: String {
            return "\(baseURL)/users"
        }
        static func detail(id: Int) -> String {
            return "\(baseURL)/users/\(id)"
        }
    }
}
