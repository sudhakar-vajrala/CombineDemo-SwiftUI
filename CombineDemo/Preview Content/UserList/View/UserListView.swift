//
//  UserListView.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//
import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UsersViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(userOld: user)) {
                        HStack {
                            AsyncImage(url: URL(string: user.avatar)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            Text(user.first_name)
                                .font(.headline)
                            Text(user.last_name)
                                .font(.subheadline)
                        }
                        .onAppear {
                            // Trigger next page load when last item appears
                            if user == viewModel.users.last {
                                viewModel.fetchNextPage()
                            }
                        }
                    }
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchNextPage()
            }
        }
    }
}

