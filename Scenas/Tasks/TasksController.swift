//
//  TasksController.swift
//  Betfair
//
//  Created by Gio's Mac on 01.03.25.
//

import UIKit
import SnapKit

class TasksController: UIViewController {

    private lazy var topView: TopView = {
        let view = TopView()
        return view
    }()

    private lazy var chooseFirstWorkoutView: ChooseFirstWorkoutView = {
        let view = ChooseFirstWorkoutView()
        view.didPressGetStartedButton = { [weak self] in
            self?.getStartFirstWorkout()
        }
        return view
    }()

    private lazy var chooseSecondWorkoutView: ChooseSecondWorkoutView = {
        let view = ChooseSecondWorkoutView()
        return view
    }()

    private lazy var chooseThirdWorkoutView: ChooseThirdWorkoutView = {
        let view = ChooseThirdWorkoutView()
        return view
    }()

    private lazy var timerView: TimerView = {
        let view = TimerView()
        view.didPressStartedButton = { [weak self] in
            self?.startCountdown()
        }
        view.isHidden = true
        return view
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(topView)
        view.addSubview(chooseThirdWorkoutView)
        view.addSubview(chooseSecondWorkoutView)
        view.addSubview(chooseFirstWorkoutView)
        view.addSubview(timerView)
    }

    private func setupConstraint() {
        topView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(211 * Constraint.yCoeff)
        }

        chooseThirdWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(56 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        chooseSecondWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(72 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        chooseFirstWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(88 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        timerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func getStartFirstWorkout() {
        timerView.isHidden = false
        if let selectedWorkout = workouts.first(where: { $0.title == chooseFirstWorkoutView.workoutTitle.text }) {
            timerView.workoutTitle.text = selectedWorkout.title
            timerView.workoutDescription.text = "\(selectedWorkout.description) (\(selectedWorkout.duration) sec)"
            timerView.workoutNumberLabel.text = "\(selectedWorkout.duration) Sec"
        }
    }

    private func startCountdown() {
        timerView.startButton.setTitle("Reinvented", for: .normal)
        timerView.startButton.isUserInteractionEnabled = false
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)
        let countdownNumbers = ["3", "2", "1", "GO"]
        var index = 0

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if index < countdownNumbers.count {
                self.timerView.workoutNumberLabel.text = countdownNumbers[index]
                index += 1
            } else {
                timer.invalidate()
                self.startWorkoutTimer()
            }
        }
    }

    private func startWorkoutTimer() {
        timerView.startButton.isUserInteractionEnabled = true
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow

        guard let durationText = timerView.workoutNumberLabel.text?.components(separatedBy: " ").first,
              let duration = Int(durationText) else { return }

        var timeRemaining = duration
        timerView.workoutNumberLabel.text = "\(timeRemaining)"

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"
            } else {
                timer.invalidate()
                self.timerView.workoutNumberLabel.text = "Completed!"
            }
        }
    }
}
