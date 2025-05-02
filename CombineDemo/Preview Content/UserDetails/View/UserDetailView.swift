//
//  UserDetailView.swift
//  CombineDemo
//
//  Created by Venkata Sudhakar Reddy on 21/04/25.
//
import SwiftUI

struct UserDetailView: View {
    let userOld: User
    @StateObject private var viewModel = UserDetailViewModel()

    var body: some View {
        Group {
            if let userDetail = viewModel.userDetail {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: userDetail.data.avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())

                    Text(userDetail.data.first_name)
                        .font(.title)
                    Text(userDetail.support.url)
                        .font(.subheadline)

                    Spacer()
                }
                .padding()
            } else {
                ProgressView("Loading...")
            }
        }
        .navigationTitle("User Details")
        .onAppear {
            viewModel.fetchUser(by: userOld.id)
        }
    }
}

