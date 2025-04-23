

import Foundation

class ProfileViewModel {
    var users: [UserInfo] = []

    var onShowChangeUserInfoView: (() -> Void)?
    var onHideChangeUserInfoView: (() -> Void)?
    var onUpdateUserInfo: (() -> Void)?
    var onSaveUserInfo: (() -> Void)?

    func loadUsers() {
        users = [
            UserInfo(image: "yellowCircle", userName: "Alice", userRating: "1200"),
            UserInfo(image: "yellowCircle", userName: "Bob", userRating: "1500"),
            UserInfo(image: "yellowCircle", userName: "Charlie", userRating: "1800"),
            UserInfo(image: "yellowCircle", userName: "Tom", userRating: "900"),
            UserInfo(image: "yellowCircle", userName: "Non", userRating: "1000"),
            UserInfo(image: "yellowCircle", userName: "Tat", userRating: "700")
        ]
    }

    func showChangeUserInfoView() {
        onShowChangeUserInfoView?()
    }

    func hideChangeUserInfoView() {
        onHideChangeUserInfoView?() 
    }

    func updateUserInfo() {
        onUpdateUserInfo?()
    }

    func saveUserInfo() {
        onSaveUserInfo?()
    }
}
