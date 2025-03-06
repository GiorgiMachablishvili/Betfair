//
//  UsersCell.swift
//  Betfair
//
//  Created by Gio's Mac on 05.03.25.
//

import UIKit
import SnapKit

class UsersCell: UICollectionViewCell {

    private lazy var mainViewBackGround: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(16)
        return view
    }()

    private lazy var numberingBackGroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.makeRoundCorners(14)
        return view
    }()

    private lazy var numberingMark: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "#"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 12)
        view.textAlignment = .center
        return view
    }()

    private lazy var numberingLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "1"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .center
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(12)
        return view
    }()

    private lazy var userNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "SoccerPlayer"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .left
        return view
    }()

    private lazy var workoutImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "dailiImage")
        view.contentMode = .scaleToFill
        return view
    }()

    private lazy var userWorkoutLabeL: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "23"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var pointsLabeL: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "123"
        view.textColor = UIColor.mainViewsBackgroundYellow
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .right
        return view
    }()

    private lazy var pintsImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "pointImage")
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(mainViewBackGround)
        addSubview(numberingBackGroundView)
        addSubview(numberingMark)
        addSubview(numberingLabel)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(workoutImage)
        addSubview(userWorkoutLabeL)
        addSubview(pointsLabeL)
        addSubview(pintsImage)
    }

    private func setupConstraint() {
        mainViewBackGround.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12 * Constraint.xCoeff)
            make.height.equalTo(70 * Constraint.yCoeff)
        }

        numberingBackGroundView.snp.remakeConstraints { make in
            make.centerY.equalTo(mainViewBackGround)
            make.leading.equalTo(mainViewBackGround.snp.leading).offset(12 * Constraint.xCoeff)
            make.height.equalTo(29 * Constraint.yCoeff)
            make.width.equalTo(43 * Constraint.xCoeff)
        }

        numberingMark.snp.remakeConstraints { make in
            make.centerY.equalTo(numberingBackGroundView)
            make.leading.equalTo(numberingBackGroundView.snp.leading).offset(12 * Constraint.xCoeff)
//            make.height.equalTo(18 * Constraint.yCoeff)
        }

        numberingLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(numberingBackGroundView)
            make.leading.equalTo(numberingMark.snp.trailing).offset(2 * Constraint.xCoeff)
//            make.height.equalTo(18 * Constraint.yCoeff)
        }

        userImage.snp.remakeConstraints { make in
            make.centerY.equalTo(mainViewBackGround)
            make.leading.equalTo(numberingBackGroundView.snp.trailing).offset(8 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.top.equalTo(mainViewBackGround.snp.top).offset(12 * Constraint.yCoeff)
            make.leading.equalTo(userImage.snp.trailing).offset(8 * Constraint.xCoeff)
        }

        workoutImage.snp.remakeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom)
            make.leading.equalTo(userImage.snp.trailing).offset(8 * Constraint.xCoeff)
            make.height.width.equalTo(27 * Constraint.yCoeff)
            make.width.equalTo(25 * Constraint.xCoeff)
        }

        userWorkoutLabeL.snp.remakeConstraints { make in
            make.centerY.equalTo(workoutImage)
            make.leading.equalTo(workoutImage.snp.trailing).offset(4 * Constraint.xCoeff)
//            make.height.width.equalTo(17 * Constraint.yCoeff)
        }

        pointsLabeL.snp.remakeConstraints { make in
            make.centerY.equalTo(pintsImage)
            make.trailing.equalTo(pintsImage.snp.leading).offset(-8)
        }

        pintsImage.snp.remakeConstraints { make in
            make.centerY.equalTo(mainViewBackGround)
            make.trailing.equalTo(mainViewBackGround.snp.trailing).offset(-12 * Constraint.xCoeff)
            make.height.width.equalTo(20 * Constraint.yCoeff)
        }
    }

    func configuration(with data: UserInfo) {
        userImage.image = UIImage(named: "\(data.image)")
        userNameLabel.text = data.userName
        pointsLabeL.text = data.userRating
    }
}
