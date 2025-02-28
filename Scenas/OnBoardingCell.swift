//
//  OnBoardingCell.swift
//  Betfair
//
//  Created by Gio's Mac on 28.02.25.
//

import UIKit
import SnapKit

class OnBoardingCell: UICollectionViewCell {
    private lazy var mainImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "onboarding1")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var onboardTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Fast and secure \n authorization"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 24)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var onboardInfo: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Authorize via Apple ID to save your progress, achievements and predictions. Fast, secure, no extra data."
        view.textColor = UIColor.whiteColor.withAlphaComponent(0.6)
        view.font = UIFont.poppinsRegular(size: 16)
        view.textAlignment = .center
        view.numberOfLines = 3
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainViewsBackgroundYellow
        
        setup()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(mainImage)
        addSubview(onboardTitle)
        addSubview(onboardInfo)
    }

    private func setupConstraint() {
        mainImage.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(30 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(520 * Constraint.yCoeff)
        }

        onboardTitle.snp.remakeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(5 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(36 * Constraint.xCoeff)
        }

        onboardInfo.snp.remakeConstraints { make in
            make.top.equalTo(onboardTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(36 * Constraint.xCoeff)
        }
    }

    func configure(with data: OnboardingView) {
        mainImage.image = UIImage(named: data.image)
        onboardTitle.text = data.title
        onboardInfo.text = data.viewInfo
    }
}
