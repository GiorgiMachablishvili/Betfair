//
//  CompetitionViewModel.swift
//  Betfair
//
//  Created by Gio's Mac on 20.03.25.
//

import Foundation

class CompetitionViewModel {

    var onActiveOpponentButton: (() -> Void)?
    var onCompletedButton: (() -> Void)?

    private var isShowingActive: Bool = true


    func activeOpponentButton() {
        onActiveOpponentButton?()
    }

    func completedButton() {
        onCompletedButton?()
    }
}
