//
//  CompetitionViewModel.swift
//  Betfair
//
//  Created by Gio's Mac on 20.03.25.
//

import UIKit

class CompetitionViewModel {

    var onActiveOpponentButton: (() -> Void)?
    var onCompletedButton: (() -> Void)?
    var onHideAcceptChallengedView: (() -> Void)?
    var onShowAcceptChallengedView: (() -> Void)?

    private var isShowingActive: Bool = true


    func activeOpponentButton() {
        isShowingActive = true
        onActiveOpponentButton?()
    }

    func completedButton() {
        isShowingActive = false
        onCompletedButton?()
    }

    func hideAcceptChallengedView() {
        onHideAcceptChallengedView?()
    }

    func showAcceptChallengedView() {
        onShowAcceptChallengedView?()
    }

    func updateButtonStyles(competitionTopView: CompetitionTopView) {
        if isShowingActive {
            competitionTopView.activeButton.backgroundColor = .whiteColor
            competitionTopView.activeButton.setTitleColor(.blackColor, for: .normal)

            competitionTopView.completedButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            competitionTopView.completedButton.setTitleColor(.whiteColor, for: .normal)
        } else {
            competitionTopView.completedButton.backgroundColor = .whiteColor
            competitionTopView.completedButton.setTitleColor(.blackColor, for: .normal)

            competitionTopView.activeButton.backgroundColor = UIColor.whiteColor.withAlphaComponent(0.2)
            competitionTopView.activeButton.setTitleColor(.whiteColor, for: .normal)
        }
    }
}
