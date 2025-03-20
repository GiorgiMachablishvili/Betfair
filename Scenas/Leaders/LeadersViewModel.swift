//
//  LeadersViewModel.swift
//  Betfair
//
//  Created by Gio's Mac on 20.03.25.
//

import Foundation

class LeadersViewModel {
    var users: [UserInfo] = []
    var filteredUsers: [UserInfo] = []
    var isSearching: Bool = false

    var onUsersUpdated: (() -> Void)?
    var onShowComplainView: (() -> Void)?
    var onCloseChallengeView: (() -> Void)?
    var onCloseComplaintView: (() -> Void)?

    func loadUsers() {
        users = [
            UserInfo(image: "user1", userName: "Alice", userRating: "1200"),
            UserInfo(image: "user2", userName: "Bob", userRating: "1500"),
            UserInfo(image: "user3", userName: "Charlie", userRating: "1800"),
            UserInfo(image: "user4", userName: "Tom", userRating: "900"),
            UserInfo(image: "user5", userName: "Non", userRating: "1000"),
            UserInfo(image: "user6", userName: "Tat", userRating: "700")
        ]
        users.sort { Int($0.userRating) ?? 0 > Int($1.userRating) ?? 0 }
        filteredUsers = users
        onUsersUpdated?()
    }

    func searchUsers(with searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredUsers = users
        } else {
            isSearching = true
            filteredUsers = users.filter { $0.userName.lowercased().contains(searchText.lowercased()) }
        }
        onUsersUpdated?()
    }

    func showComplainView() {
        onShowComplainView?()
    }
    func closeChallengeView() {
        onCloseChallengeView?()
    }
    func closeComplaintView() {
        onCloseComplaintView?()
    }
    func confirmButton() {
        /* TODO: Handle complaint confirmation logic */
    }
}
