//
//  URL+Extension.swift
//  Betfair
//
//  Created by Gio's Mac on 28.02.25.
//

import Foundation

extension String {
    static func userCreate() -> String {
        return "https://luckyland-giorgi-c118577c5e05.herokuapp.com/api/v1/users/"
    }

    static func voteGames() -> String {
        return "https://luckyland-giorgi-c118577c5e05.herokuapp.com/api/v1/tournaments/vote"
    }

    static func dailyBonusPost(userId: Int) -> String {
        return "\(userId)"
    }

    static func userDataResponse(userId: Int) -> String {
        return "/\(userId)"
    }

    static func leaderBoard() -> String {
        return "https://stake-us-66f6608d21e4.herokuapp.com/leaderboard"
    }

    static func userUpdateDate(userId: Int) -> String {
        return "https://stake-us-66f6608d21e4.herokuapp.com/users/\(userId)"
    }

    static func userGameHistoryPost() -> String {
        return "https://stake-us-66f6608d21e4.herokuapp.com/history/"
    }

    static func userGameHistoryGet(userId: Int) -> String {
        return "https://stake-us-66f6608d21e4.herokuapp.com/history/\(userId)"
    }

    static func userDelete(userId: Int) -> String {
        return "https://stake-us-66f6608d21e4.herokuapp.com/users/\(userId)"
    }

    static func getUserGameStatistic(userId: Int) -> String {
        return "https://stake-us-66f6608d21e4.herokuapp.com/user_statistics/\(userId)"
    }
}

