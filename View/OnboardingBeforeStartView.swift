//
//  OnboardingBeforeStartView.swift
//  Betfair
//
//  Created by Gio's Mac on 28.02.25.
//

import UIKit
import SnapKit

class OnboardingBeforeStartView: UIView {

    var didPressAcceptButton: (() -> Void)?
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

    private lazy var termsPrivacyTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.delegate = self
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.linkTextAttributes = [
            .foregroundColor: UIColor.blackColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let fullText = "By clicking the 'Accept' button, I confirm that I have read and accept the Privacy Policy and Terms of Use."

        let privacyPolicyText = "Privacy Policy"
        let termsOfUseText = "Terms of Use"

        let attributedString = NSMutableAttributedString(string: fullText, attributes: [
            .font: UIFont.poppinsRegular(size: 14),
            .foregroundColor: UIColor.blackColor
        ])

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4

        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, fullText.count))

        let privacyPolicyRange = (fullText as NSString).range(of: privacyPolicyText)
        let termsOfUseRange = (fullText as NSString).range(of: termsOfUseText)

        attributedString.addAttribute(.link, value: "privacyPolicy", range: privacyPolicyRange)
        attributedString.addAttribute(.link, value: "termsOfUse", range: termsOfUseRange)

        view.attributedText = attributedString
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
        addSubview(termsPrivacyTextView)
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

        termsPrivacyTextView.snp.remakeConstraints { make in
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
        didPressAcceptButton?()
    }

    @objc private func clickCloseButton() {
        didPressCloseButton?()
    }
}

extension OnboardingBeforeStartView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "privacyPolicy" {
            openPrivacyPolicy()
        } else if URL.absoluteString == "termsOfUse" {
            openTermsOfUse()
        }
        return false
    }

    //TODO: add links
    private func openPrivacyPolicy() {
        print("Privacy Policy Clicked")
    }

    private func openTermsOfUse() {
        print("Terms of Use Clicked")
    }
}
