//
//  UsersViewModel.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//
import Foundation
import Combine
import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()
    private var skipToken: String? = nil
    private var reachedEnd = false

    func fetchNextPage() {
        guard !isLoading, !reachedEnd else { return }

        isLoading = true
        
        APIService.shared.fetchData(APIEndpoint.User.list)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { (response: PaginatedResponse) in
                self.users += response.data
                let pageCount = (response.page ?? 0) + 1
                self.skipToken = "\(String(describing: pageCount))"
                
                if response.page == response.total_pages {
                    self.reachedEnd = true
                }
            })
            .store(in: &cancellables)
        
/*
///with skip
        APIService.shared.fetchUsers(skipToken: skipToken)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { response in
                self.users += response.data
                let pageCount = (response.page ?? 0) + 1
                self.skipToken = "\(String(describing: pageCount))"

                if response.page == response.total_pages {
                    self.reachedEnd = true
                }
            })
            .store(in: &cancellables)*/
    }
}
