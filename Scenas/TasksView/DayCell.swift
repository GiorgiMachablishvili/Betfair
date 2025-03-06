

import UIKit
import SnapKit

class DayCell: UICollectionViewCell {

    private let dayLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.poppinsRegular(size: 10)
        view.textColor = .whiteColor
        view.textAlignment = .center
        return view
    }()

    private let pointView: UIView = {
        let view = UIView()
        view.makeRoundCorners(12 * Constraint.yCoeff)
        view.backgroundColor = .whiteColor
        return view
    }()

    private let redPoint: UIView = {
        let view = UIView()
        view.makeRoundCorners(4)
        view.backgroundColor = .clear
        view.backgroundColor = .mainViewsBackgroundYellow
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
        addSubview(dayLabel)
        addSubview(pointView)
        pointView.addSubview(redPoint)
    }

    private func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.top.centerX.equalToSuperview()
            make.height.equalTo(12 * Constraint.yCoeff)
            make.width.equalTo(24 * Constraint.xCoeff)
        }

        pointView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(4 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24 * Constraint.yCoeff)
        }

        redPoint.snp.remakeConstraints { make in
            make.center.equalTo(pointView.snp.center)
            make.height.width.equalTo(8 * Constraint.yCoeff)
        }
    }

    func configure(with data: CalendarInfo) {
        dayLabel.text = data.dayName
//        dayLabel.textColor = data.isToday ? .red : .gray
        pointView.backgroundColor = data.isToday ? .mainViewsBackgroundYellow : .whiteColor
        redPoint.isHidden = !data.isToday
    }
}
