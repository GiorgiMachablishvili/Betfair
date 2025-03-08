

import UIKit
import SnapKit

class ChosenOpponentCell: UICollectionViewCell {

    private lazy var userViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(56)
        return view
    }()

    lazy var userNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "SoccerPlayer"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var userRatingView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(15)
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var topLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "#"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 12)
        view.textAlignment = .left
        return view
    }()

    lazy var ratingNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "2764"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    lazy var refuseButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Refuse", for: .normal)
        view.backgroundColor = UIColor.blackColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickRefuseButton), for: .touchUpInside)
        return view
    }()

    lazy var acceptButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Accept", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickAcceptButton), for: .touchUpInside)
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
        addSubview(userViewBackground)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(userRatingView)
        addSubview(topLabel)
        addSubview(ratingNumberLabel)
        addSubview(refuseButton)
        addSubview(acceptButton)
    }

    private func setupConstraint() {
        userViewBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        userImage.snp.remakeConstraints { make in
            make.centerX.equalTo(userViewBackground)
            make.top.equalTo(userViewBackground.snp.top).offset(19 * Constraint.yCoeff)
            make.height.width.equalTo(113 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userViewBackground)
            make.top.equalTo(userImage.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        userRatingView.snp.remakeConstraints { make in
            make.centerX.equalTo(userViewBackground)
            make.top.equalTo(userNameLabel.snp.bottom).offset(4 * Constraint.yCoeff)
            make.height.equalTo(29 * Constraint.yCoeff)
            make.width.equalTo(71 * Constraint.xCoeff)
        }

        topLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userRatingView)
            make.leading.equalTo(userRatingView.snp.leading).offset(12 * Constraint.xCoeff)
        }

        ratingNumberLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userRatingView)
            make.leading.equalTo(topLabel.snp.trailing).offset(4 * Constraint.xCoeff)
        }

        //TODO: add label and info

        refuseButton.snp.remakeConstraints { make in
            make.top.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
        }
    }

    @objc private func clickRefuseButton() {

    }

    @objc private func clickAcceptButton() {

    }
}
