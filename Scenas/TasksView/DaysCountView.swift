//
//  DaysCountView.swift
//  Betfair
//
//  Created by Gio's Mac on 01.03.25.
//

import UIKit
import SnapKit

class DaysCountView: UIView {

    lazy var dayOneBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor.withAlphaComponent(0.4)
        view.makeRoundCorners(8)
        return view
    }()

    lazy var dayTwoBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor.withAlphaComponent(0.4)
        view.makeRoundCorners(8)
        return view
    }()

    lazy var dayThreeBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor.withAlphaComponent(0.4)
        view.makeRoundCorners(8)
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
        addSubview(dayOneBackground)
        addSubview(dayTwoBackground)
        addSubview(dayThreeBackground)
    }

    private func setupConstraints() {
        dayOneBackground.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(77 * Constraint.yCoeff)
        }

        dayTwoBackground.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(dayOneBackground.snp.trailing).offset(2 * Constraint.xCoeff)
            make.width.equalTo(77 * Constraint.yCoeff)
        }

        dayThreeBackground.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(dayTwoBackground.snp.trailing).offset(2 * Constraint.xCoeff)
            make.width.equalTo(77 * Constraint.yCoeff)
        }
    }

}
