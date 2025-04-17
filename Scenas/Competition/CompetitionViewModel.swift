

import UIKit

class CompetitionViewModel {

    var onActiveOpponentButton: (() -> Void)?
    var onCompletedButton: (() -> Void)?
    var onHideAcceptChallengedView: (() -> Void)?
    var onShowAcceptChallengedView: (() -> Void)?
    var onStartTimerForWorkout: ((TrainingModelCS) -> Void)?

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

    func startTimerForWorkout(with title: String?, in workouts: [TrainingModelCS]) {
        guard let title = title,
              let selectedWorkout = workouts.first(where: { $0.title == title }) else {
            print("Workout not found in ViewModel")
            return
        }

        onStartTimerForWorkout?(selectedWorkout)
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
