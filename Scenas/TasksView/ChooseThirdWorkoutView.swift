//
//  ChooseThirdWorkoutView.swift
//  Betfair
//
//  Created by Gio's Mac on 02.03.25.
//

import UIKit
import SnapKit

class ChooseThirdWorkoutView: UIView {

    var didPressGetStartedButton: (() -> Void)?

    private lazy var workoutBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var workoutNumberView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(56.5)
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var workoutNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "3"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 40)
        view.textAlignment = .center
        return view
    }()

    lazy var workoutTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Balance on one leg"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    lazy var workoutDescription: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.attributedText = makeTopViewAttributedString(for: "20")
        view.textAlignment = .center
        return view
    }()

    private lazy var changeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("change", for: .normal)
        view.backgroundColor = UIColor.blackColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickChangeButton), for: .touchUpInside)
        return view
    }()

    private lazy var getStartedButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Get started", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickGetStartedButton), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
        loadRandomWorkout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(workoutBackground)
        addSubview(workoutNumberView)
        addSubview(workoutNumberLabel)
        addSubview(workoutTitle)
        addSubview(workoutDescription)
        addSubview(changeButton)
        addSubview(getStartedButton)
    }

    private func setupConstraints() {
        workoutBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        workoutNumberView.snp.remakeConstraints { make in
            make.top.equalTo(workoutBackground.snp.top).offset(49 * Constraint.yCoeff)
            make.centerX.equalTo(workoutBackground)
            make.height.width.equalTo(113 * Constraint.yCoeff)
        }

        workoutNumberLabel.snp.remakeConstraints { make in
            make.center.equalTo(workoutNumberView)
        }

        workoutTitle.snp.remakeConstraints { make in
            make.top.equalTo(workoutNumberView.snp.bottom).offset(50 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
            make.height.equalTo(36 * Constraint.yCoeff)
        }

        workoutDescription.snp.remakeConstraints { make in
            make.top.equalTo(workoutTitle.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
        }

        changeButton.snp.remakeConstraints { make in
            make.bottom.equalTo(workoutBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.leading.equalTo(workoutBackground.snp.leading).offset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }

        getStartedButton.snp.remakeConstraints { make in
            make.centerY.equalTo(changeButton)
            make.trailing.equalTo(workoutBackground.snp.trailing).offset(-20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }
    }

    func makeTopViewAttributedString(for sport: String) -> NSAttributedString {
        let text = "Hold your balance for \(sport.lowercased()) seconds"
        let attributedString = NSMutableAttributedString(string: text)

        let completedRange = (text as NSString).range(of: "Hold your balance for ")
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: completedRange)

        let sportRange = (text as NSString).range(of: sport.lowercased())
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: sportRange)

        let dayRange = (text as NSString).range(of: " seconds")
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: dayRange)

        return attributedString
    }

    private func loadRandomWorkout() {
            guard let randomWorkout = workouts.randomElement() else { return }
            workoutTitle.text = randomWorkout.title
            workoutDescription.text = "\(randomWorkout.description) (\(randomWorkout.duration) sec)"
        }

    @objc private func clickChangeButton() {
        loadRandomWorkout()
    }

    @objc private func clickGetStartedButton() {
        didPressGetStartedButton?()
    }
}
