

import UIKit
import SnapKit

class CompletedCell: UICollectionViewCell {
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

    lazy var dataLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "12 April 2024"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsRegular(size: 12)
        view.textAlignment = .center
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(30)
        return view
    }()

    lazy var userNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "You"
        view.textColor = UIColor.mainViewsBackgroundYellow
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var userScoreView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(14)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var userScoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "4"
        view.font = UIFont.poppinsBold(size: 14)
        view.textColor = .whiteColor
        view.textAlignment = .center
        return view
    }()

    private lazy var vsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "VS"
        view.font = UIFont.poppinsBold(size: 20)
        view.textColor = .blackColor
        view.textAlignment = .center
        return view
    }()

    private lazy var opponentImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(30)
        return view
    }()

    lazy var opponentNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "SoccerPlayer"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var opponentImageScoreView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(14)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var opponentScoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "30"
        view.font = UIFont.poppinsBold(size: 14)
        view.textColor = .whiteColor
        view.textAlignment = .center
        return view
    }()

    private lazy var winOrLossLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "YOU WIN"
        view.font = UIFont.poppinsBold(size: 24)
        view.textColor = .mainViewsBackgroundYellow
        view.textAlignment = .center
        return view
    }()

    private lazy var revancheButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Revanche", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickRevancheButton), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraint()

        updateWinOrLossStatus()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(userViewBackground)
        addSubview(yellowWhiteBackground)
        addSubview(dataLabel)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(userScoreView)
        userScoreView.addSubview(userScoreLabel)
        addSubview(vsLabel)
        addSubview(opponentImage)
        addSubview(opponentNameLabel)
        addSubview(opponentImageScoreView)
        opponentImageScoreView.addSubview(opponentScoreLabel)
        addSubview(winOrLossLabel)
        addSubview(revancheButton)
    }

    private func setupConstraint() {
        userViewBackground.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(368 * Constraint.yCoeff)
        }

        yellowWhiteBackground.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(212 * Constraint.yCoeff)
        }

        dataLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userViewBackground)
            make.top.equalTo(userViewBackground.snp.top).offset(16 * Constraint.yCoeff)
        }

        userImage.snp.remakeConstraints { make in
            make.top.equalTo(userViewBackground.snp.top).offset(62 * Constraint.yCoeff)
            make.leading.equalTo(userViewBackground.snp.leading).offset(40 * Constraint.xCoeff)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userImage)
            make.top.equalTo(userImage.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        userScoreView.snp.remakeConstraints { make in
            make.bottom.equalTo(userImage.snp.bottom)
            make.leading.equalTo(userImage.snp.trailing).offset(15.5 * Constraint.xCoeff)
            make.height.equalTo(29 * Constraint.yCoeff)
            make.width.equalTo(34 * Constraint.xCoeff)
        }

        userScoreLabel.snp.remakeConstraints { make in
            make.center.equalTo(userScoreView)
            make.height.equalTo(21 * Constraint.yCoeff)
        }

        vsLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userScoreView)
            make.centerX.equalTo(userViewBackground)
        }

        opponentImage.snp.remakeConstraints { make in
            make.top.equalTo(userViewBackground.snp.top).offset(62 * Constraint.yCoeff)
            make.trailing.equalTo(userViewBackground.snp.trailing).offset(-40 * Constraint.xCoeff)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }

        opponentNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(opponentImage)
            make.top.equalTo(opponentImage.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        opponentImageScoreView.snp.remakeConstraints { make in
            make.bottom.equalTo(opponentImage.snp.bottom)
            make.trailing.equalTo(opponentImage.snp.leading).offset(-15.5 * Constraint.xCoeff)
            make.height.equalTo(29 * Constraint.yCoeff)
            make.width.equalTo(34 * Constraint.xCoeff)
        }

        opponentScoreLabel.snp.remakeConstraints { make in
            make.center.equalTo(opponentImageScoreView)
            make.height.equalTo(21 * Constraint.yCoeff)
        }

        revancheButton.snp.remakeConstraints { make in
            make.bottom.equalTo(userViewBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.leading.trailing.equalTo(userViewBackground).inset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

        winOrLossLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(revancheButton.snp.top).offset(-20 * Constraint.yCoeff)
            make.centerX.equalTo(userViewBackground)
        }
    }

    func updateWinOrLossStatus() {
        guard let userScore = Int(userScoreLabel.text ?? "0"),
              let opponentScore = Int(opponentScoreLabel.text ?? "0") else {
            return
        }

        if userScore > opponentScore {
            winOrLossLabel.text = "YOU WIN"
            winOrLossLabel.textColor = .mainViewsBackgroundYellow
        } else if userScore < opponentScore {
            winOrLossLabel.text = "YOU LOSE"
            winOrLossLabel.textColor = .blackColor
        } else {
            winOrLossLabel.text = "DRAW"
            winOrLossLabel.textColor = .gray
        }
    }

    //TODO: add func
    @objc private func clickRevancheButton() {

    }
}
