

import UIKit
import SnapKit

class UserChallengeView: UIView {

    private lazy var viewMainBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var workoutBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(60)
        return view
    }()

    lazy var nicknameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Nickname"
        view.textColor = UIColor.gayBackground
        view.font = UIFont.poppinsBold(size: 10)
        view.textAlignment = .center
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
        view.text = "TOP"
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

    lazy var complaintButton: UIButton = {
        let view = UIButton(frame: .zero)
        let originalImage = UIImage(named: "complaint")
        let resizedImage = originalImage?.resized(to: CGSize(width: 18, height: 20))
        view.setImage(resizedImage, for: .normal)
        view.backgroundColor = .blackColor.withAlphaComponent(0.1)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickComplaintButton), for: .touchUpInside)
        return view
    }()

    lazy var challengeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Challenge the user", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickChallengeButton), for: .touchUpInside)
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
        addSubview(userImage)
        addSubview(nicknameLabel)
        addSubview(userNameLabel)
        addSubview(userRatingView)
        addSubview(topLabel)
        addSubview(ratingNumberLabel)
        addSubview(complaintButton)
        addSubview(challengeButton)
        addSubview(closeButton)
    }

    private func setupConstraints() {
        viewMainBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        workoutBackground.snp.remakeConstraints { make in
            make.top.equalTo(viewMainBackground.snp.top).offset(395 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(350 * Constraint.yCoeff)
        }

        userImage.snp.remakeConstraints { make in
            make.centerX.equalTo(workoutBackground)
            make.top.equalTo(workoutBackground.snp.top).offset(32 * Constraint.yCoeff)
            make.height.width.equalTo(120 * Constraint.yCoeff)
        }

        nicknameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userImage)
            make.top.equalTo(userImage.snp.bottom).offset(19 * Constraint.yCoeff)
//            make.height.width.equalTo(120 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userImage)
            make.top.equalTo(nicknameLabel.snp.bottom)
//            make.height.width.equalTo(120 * Constraint.yCoeff)
        }

        userRatingView.snp.remakeConstraints { make in
            make.centerX.equalTo(userImage)
            make.top.equalTo(userNameLabel.snp.bottom)
            make.height.equalTo(30 * Constraint.yCoeff)
            make.width.equalTo(90 * Constraint.xCoeff)
        }

        topLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userRatingView)
            make.leading.equalTo(userRatingView.snp.leading).offset(12 * Constraint.xCoeff)
        }

        ratingNumberLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userRatingView)
            make.leading.equalTo(topLabel.snp.trailing).offset(4 * Constraint.xCoeff)
        }

        complaintButton.snp.remakeConstraints { make in
            make.top.equalTo(userRatingView.snp.bottom).offset(18 * Constraint.yCoeff)
            make.leading.equalTo(workoutBackground.snp.leading).offset(32 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(68 * Constraint.xCoeff)
        }

        challengeButton.snp.remakeConstraints { make in
            make.top.equalTo(userRatingView.snp.bottom).offset(18 * Constraint.yCoeff)
            make.trailing.equalTo(workoutBackground.snp.trailing).offset(-32 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(218 * Constraint.xCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.top.equalTo(workoutBackground.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

    }

    @objc private func clickComplaintButton() {

    }

    @objc private func clickChallengeButton() {

    }

    @objc private func clickCloseButton() {

    }

}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
