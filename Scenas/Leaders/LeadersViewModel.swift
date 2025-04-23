

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
            UserInfo(image: "yellowCircle", userName: "Alice", userRating: "1200"),
            UserInfo(image: "yellowCircle", userName: "Bob", userRating: "1500"),
            UserInfo(image: "yellowCircle", userName: "Charlie", userRating: "1800"),
            UserInfo(image: "yellowCircle", userName: "Tom", userRating: "900"),
            UserInfo(image: "yellowCircle", userName: "Non", userRating: "1000"),
            UserInfo(image: "yellowCircle", userName: "Tat", userRating: "700")
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
