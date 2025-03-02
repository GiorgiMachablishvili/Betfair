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
}
