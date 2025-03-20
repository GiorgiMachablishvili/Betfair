//
//  ProfileViewModel.swift
//  Betfair
//
//  Created by Gio's Mac on 20.03.25.
//

import Foundation

class ProfileViewModel {
    var users: [UserInfo] = []

    var onShowChangeUserInfoView: (() -> Void)?
    var onHideChangeUserInfoView: (() -> Void)?
    var onUpdateUserInfo: (() -> Void)?
    var onSaveUserInfo: (() -> Void)?

    func loadUsers() {
        users = [
            UserInfo(image: "user1", userName: "Alice", userRating: "1200"),
            UserInfo(image: "user2", userName: "Bob", userRating: "1500"),
            UserInfo(image: "user3", userName: "Charlie", userRating: "1800"),
            UserInfo(image: "user4", userName: "Tom", userRating: "900"),
            UserInfo(image: "user5", userName: "Non", userRating: "1000"),
            UserInfo(image: "user6", userName: "Tat", userRating: "700")
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
