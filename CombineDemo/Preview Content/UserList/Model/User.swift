//
//  User.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let avatar: String
}

struct PaginatedResponse: Codable {
    let data: [User]
    let page: Int?
    let total_pages: Int?
}

struct UserDetailResponse: Codable, Equatable {
    let data: User
    let support: Support
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}

