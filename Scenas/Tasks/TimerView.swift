//
//  TimerView.swift
//  Betfair
//
//  Created by Gio's Mac on 02.03.25.
//

import UIKit
import SnapKit

class TimerView: UIView {

    var didPressStartedButton: (() -> Void)?

    private lazy var viewMainBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var workoutBackgroundCircle: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "yellowCircle")
        view.contentMode = .scaleAspectFit
        return view
    }()

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
        view.text = "1"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 24)
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

    lazy var startButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Start", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickStartedButton), for: .touchUpInside)
        return view
    }()

    private lazy var closeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Close", for: .normal)
        view.backgroundColor = UIColor.whiteColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.blackColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(viewMainBackground)
        addSubview(workoutBackground)
        addSubview(workoutBackgroundCircle)
        addSubview(workoutNumberView)
        addSubview(workoutNumberLabel)
        addSubview(workoutTitle)
        addSubview(workoutDescription)
        addSubview(startButton)
        addSubview(closeButton)
    }

    private func setupConstraints() {
        viewMainBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        workoutBackground.snp.makeConstraints { make in
            make.top.equalTo(viewMainBackground.snp.top).offset(355 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        workoutBackgroundCircle.snp.remakeConstraints { make in
            make.center.equalTo(workoutNumberView)
            make.height.width.equalTo(140 * Constraint.yCoeff)
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

        startButton.snp.remakeConstraints { make in
            make.bottom.equalTo(workoutBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.trailing.equalTo(workoutBackground.snp.trailing).offset(-20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(318 * Constraint.xCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.top.equalTo(workoutBackground.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }
    }

    func makeTopViewAttributedString(for time: String) -> NSAttributedString {
        let text = "Hold your balance for \(time.lowercased()) seconds"
        let attributedString = NSMutableAttributedString(string: text)

        let completedRange = (text as NSString).range(of: "Hold your balance for ")
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: completedRange)

        let sportRange = (text as NSString).range(of: time.lowercased())
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

    @objc private func clickStartedButton() {
        didPressStartedButton?()
    }

    @objc private func clickCloseButton() {

    }
}
