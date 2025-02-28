//
//  OnboardingBeforeStartView.swift
//  Betfair
//
//  Created by Gio's Mac on 28.02.25.
//

import UIKit
import SnapKit

class OnboardingBeforeStartView: UIView {

    var didPressCloseButton: (() -> Void)?

    private lazy var viewMainBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var beforeStartBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var beforeStartImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "beforeStartImage")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var beforeStartTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Before you start"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    private lazy var beforeStartInfo: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "By clicking the 'Accept' button, I confirm that I have read and accept the Privacy Policy and Terms of Use."
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsRegular(size: 14)
        view.textAlignment = .center
        view.numberOfLines = 3
        return view
    }()

    private lazy var acceptButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Accept", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickAcceptButton), for: .touchUpInside)
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
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(viewMainBackground)
        addSubview(beforeStartBackground)
        addSubview(beforeStartImage)
        addSubview(beforeStartTitle)
        addSubview(beforeStartInfo)
        addSubview(acceptButton)
        addSubview(closeButton)
    }

    private func setupConstraint() {
        viewMainBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        beforeStartBackground.snp.remakeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-100 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(430 * Constraint.yCoeff)
        }

        beforeStartImage.snp.remakeConstraints { make in
            make.top.equalTo(beforeStartBackground.snp.top)
            make.leading.equalTo(beforeStartBackground.snp.leading)
            make.trailing.equalTo(beforeStartBackground.snp.trailing)
            make.height.equalTo(212 * Constraint.yCoeff)
        }

        beforeStartTitle.snp.remakeConstraints { make in
            make.top.equalTo(beforeStartImage.snp.bottom).offset(20 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
            make.height.equalTo(36 * Constraint.yCoeff)
        }

        beforeStartInfo.snp.remakeConstraints { make in
            make.top.equalTo(beforeStartTitle.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
        }

        acceptButton.snp.remakeConstraints { make in
            make.bottom.equalTo(beforeStartBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.top.equalTo(beforeStartBackground.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }
    }


    @objc private func clickAcceptButton() {
        print("press accept button")

    }

    @objc private func clickCloseButton() {
        didPressCloseButton?()
        print( "press close button")
    }
}
