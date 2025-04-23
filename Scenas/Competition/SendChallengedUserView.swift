

import UIKit
import SnapKit

class SendChallengedUserView: UIView {

    private lazy var userViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var yellowWhiteBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "yellowWhiteBackgroound")
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

    lazy var youBeenChallengedLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "You challenged this user"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    lazy var challengedInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Complete more challenges than your opponent "
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsRegular(size: 14)
        view.numberOfLines = 2
        view.textAlignment = .center
        return view
    }()

    lazy var cancelButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Cancel", for: .normal)
        view.backgroundColor = UIColor.gayBackground.withAlphaComponent(0.1)
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.blackColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
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
        addSubview(yellowWhiteBackground)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(userRatingView)
        addSubview(topLabel)
        addSubview(ratingNumberLabel)
        addSubview(youBeenChallengedLabel)
        addSubview(challengedInfoLabel)
        addSubview(cancelButton)
    }

    private func setupConstraint() {
        userViewBackground.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(410 * Constraint.yCoeff)
        }

        yellowWhiteBackground.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(212 * Constraint.yCoeff)
        }

        userImage.snp.remakeConstraints { make in
            make.centerX.equalTo(userViewBackground)
            make.top.equalTo(userViewBackground.snp.top).offset(19 * Constraint.yCoeff)
            make.height.width.equalTo(113 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userViewBackground)
            make.top.equalTo(userImage.snp.bottom).offset(4 * Constraint.yCoeff)
            make.height.equalTo(24 * Constraint.yCoeff)
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

        youBeenChallengedLabel.snp.remakeConstraints { make in
            //            make.centerY.equalTo(userViewBackground)
            make.top.equalTo(userRatingView.snp.bottom).offset(39 * Constraint.xCoeff)
            make.height.equalTo(36 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
        }

        challengedInfoLabel.snp.remakeConstraints { make in
            make.top.equalTo(youBeenChallengedLabel.snp.bottom)
            make.centerX.equalTo(userViewBackground)
            make.height.equalTo(42 * Constraint.yCoeff)
            make.width.equalTo(300 * Constraint.xCoeff)
        }

        cancelButton.snp.remakeConstraints { make in
            make.top.equalTo(challengedInfoLabel.snp.bottom).offset(20 * Constraint.yCoeff)
            make.leading.equalTo(userViewBackground.snp.leading).offset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(318 * Constraint.xCoeff)
        }

    }

    @objc func clickCancelButton() {

    }
}
