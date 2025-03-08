

import UIKit
import SnapKit

class CompetitionTopView: UIView {
    private lazy var topViewBackGround: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blackColor
        view.makeRoundCorners(24)
        return view
    }()

    private lazy var competitionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Competitions"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 32)
        view.textAlignment = .center
        return view
    }()

    lazy var activeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Active", for: .normal)
        view.backgroundColor = UIColor.whiteColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.blackColor, for: .normal)
        view.makeRoundCorners(16)
        view.addTarget(self, action: #selector(clickActiveButton), for: .touchUpInside)
        return view
    }()

    lazy var completedButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Completed", for: .normal)
        view.backgroundColor = UIColor.whiteColor.withAlphaComponent(0.2)
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(16)
        view.addTarget(self, action: #selector(clickCompletedButton), for: .touchUpInside)
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
        addSubview(topViewBackGround)
        addSubview(competitionLabel)
        addSubview(activeButton)
        addSubview(completedButton)
    }

    private func setupConstraint() {
        topViewBackGround.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        competitionLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(topViewBackGround)
            make.top.equalTo(topViewBackGround.snp.top).offset(60 * Constraint.yCoeff)
        }

        activeButton.snp.remakeConstraints { make in
            make.top.equalTo(competitionLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(topViewBackGround.snp.leading).offset(26 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(168 * Constraint.xCoeff)
        }

        completedButton.snp.remakeConstraints { make in
            make.top.equalTo(competitionLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.trailing.equalTo(topViewBackGround.snp.trailing).offset(-26 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(168 * Constraint.xCoeff)
        }
    }

    @objc private func clickActiveButton() {

    }

    @objc private func clickCompletedButton() {

    }

}
