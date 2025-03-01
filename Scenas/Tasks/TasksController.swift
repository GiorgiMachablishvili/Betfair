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

    private lazy var chooseWorkoutView: ChooseWorkoutView = {
        let view = ChooseWorkoutView()
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
        view.addSubview(chooseWorkoutView)

    }

    private func setupConstraint() {
        topView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(211 * Constraint.yCoeff)
        }

        chooseWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(88 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }
    }

}
