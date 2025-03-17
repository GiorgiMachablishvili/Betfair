

import UIKit
import SnapKit

class DoNotHaveChallengesView: UIView {

    private lazy var yellowWhiteBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "doNotHaveChallengeImage")
        return view
    }()

    private lazy var youDoNotHaveAnyChallengesLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "You don't have any Challenges"
        view.textColor = UIColor.whiteColor.withAlphaComponent(0.2)
        view.font = UIFont.poppinsMedium(size: 16)
        view.textAlignment = .center
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(yellowWhiteBackground)
        addSubview(youDoNotHaveAnyChallengesLabel)
    }

    private func setupConstraints() {
        yellowWhiteBackground.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(120 * Constraint.yCoeff)
        }

        youDoNotHaveAnyChallengesLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(yellowWhiteBackground)
            make.top.equalTo(yellowWhiteBackground.snp.bottom).offset(16 * Constraint.yCoeff)
        }
    }
}
