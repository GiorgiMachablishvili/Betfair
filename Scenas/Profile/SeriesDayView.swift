//
//  SeriesDayView.swift
//  Betfair
//
//  Created by Gio's Mac on 07.03.25.
//

import UIKit
import SnapKit

class SeriesDayView: UIView {

    private var daysCount: Int = 140

    private lazy var seriesBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gayBackground
        view.makeRoundCorners(20)
        return view
    }()

    private lazy var seriesImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "dailiImage")
        view.contentMode = .scaleAspectFill
//        view.makeRoundCorners(40)
        return view
    }()

    private lazy var daysLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "\(daysCount) days"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .center
        return view
    }()


    private lazy var yourSeriesLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Your series"
        view.textColor = UIColor.whiteColor.withAlphaComponent(0.6)
        view.font = UIFont.poppinsBold(size: 11)
        view.textAlignment = .center
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
        addSubview(seriesBackground)
        addSubview(seriesImage)
        addSubview(daysLabel)
        addSubview(yourSeriesLabel)
    }

    private func setupConstraints() {
        seriesBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        seriesImage.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(seriesBackground.snp.top).offset(22 * Constraint.yCoeff)
            make.height.equalTo(52 * Constraint.yCoeff)
            make.width.equalTo(44 * Constraint.xCoeff)
        }

        daysLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(seriesImage.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        yourSeriesLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(daysLabel.snp.bottom)
        }
    }
}
