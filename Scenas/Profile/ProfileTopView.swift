

import UIKit
import SnapKit

class ProfileTopView: UIView {

    var didPressProfileAddButton: (() -> Void)?

    private lazy var topViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blackColor
        view.makeRoundCorners(32)
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "yellowCircle")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(40)
        return view
    }()

    private lazy var userNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Gamer"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 20)
        view.textAlignment = .left
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

    lazy var profileAddButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "menuDots"), for: .normal)
        view.backgroundColor = UIColor.whiteColor.withAlphaComponent(0.2)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(22)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(clickProfileAddButton), for: .touchUpInside)
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
        addSubview(topViewBackground)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(userRatingView)
        addSubview(topLabel)
        addSubview(ratingNumberLabel)
        addSubview(profileAddButton)
    }

    private func setupConstraints() {
        topViewBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        userImage.snp.remakeConstraints { make in
            make.top.equalTo(topViewBackground.snp.top).offset(60 * Constraint.yCoeff)
            make.leading.equalTo(topViewBackground.snp.leading).offset(24 * Constraint.xCoeff)
            make.width.height.equalTo(80 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.top.equalTo(userImage.snp.top).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(userImage.snp.trailing).offset(8 * Constraint.xCoeff)
        }

        userRatingView.snp.remakeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.equalTo(userImage.snp.trailing).offset(8 * Constraint.xCoeff)
            make.height.equalTo(30 * Constraint.yCoeff)
            make.width.equalTo(100 * Constraint.xCoeff)
        }

        topLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userRatingView)
            make.leading.equalTo(userRatingView.snp.leading).offset(12 * Constraint.xCoeff)
        }

        ratingNumberLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userRatingView)
            make.leading.equalTo(topLabel.snp.trailing).offset(4 * Constraint.xCoeff)
        }

        profileAddButton.snp.remakeConstraints { make in
            make.top.equalTo(userImage.snp.top)
            make.trailing.equalTo(topViewBackground.snp.trailing).offset(-24 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }
    }

    @objc private func clickProfileAddButton() {
        didPressProfileAddButton?()
    }
}
