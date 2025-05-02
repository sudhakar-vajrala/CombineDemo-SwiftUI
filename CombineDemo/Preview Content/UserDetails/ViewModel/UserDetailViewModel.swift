//
//  UserDetailViewModel.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//

import Foundation
import Combine

class UserDetailViewModel: ObservableObject {
    @Published var userDetail: UserDetailResponse?
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()

    func fetchUser(by id: Int) {
        isLoading = true
        
        APIService.shared.fetchData(APIEndpoint.User.detail(id: id))
            //.map { (wrapper: UserDetailResponse) in wrapper.data } // If wrapped
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Detail error: \(error)")
                }
            }, receiveValue: { [weak self] (response: UserDetailResponse ) in
                self?.userDetail = response
            })
            .store(in: &cancellables)
    }
}

