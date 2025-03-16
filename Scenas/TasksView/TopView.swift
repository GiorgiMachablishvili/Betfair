

import UIKit
import SnapKit

class TopView: UIView {

    private lazy var topViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blackColor
        view.makeRoundCorners(32)
        return view
    }()

    private lazy var numberOfDays: NumberOfDaysWorkouts = {
        let view = NumberOfDaysWorkouts()
        return view
    }()

    private lazy var todayTasksLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Today's tasks"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    lazy var numberOfDaysLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.attributedText = makeTopViewAttributedString(for: "1")
        view.textAlignment = .left
        return view
    }()

    private lazy var daysCountView: DaysCountView = {
        let view = DaysCountView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.backgroundColor = .clear
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
        addSubview(topViewBackground)
        addSubview(numberOfDays)
        addSubview(todayTasksLabel)
        addSubview(numberOfDaysLabel)
        addSubview(daysCountView)
        addSubview(calendarView)
    }

    private func setupConstraint() {
        topViewBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        numberOfDays.snp.remakeConstraints { make in
            make.top.equalTo(topViewBackground.snp.top).offset(60 * Constraint.yCoeff)
            make.leading.equalTo(topViewBackground.snp.leading).offset(12 * Constraint.xCoeff)
            make.height.equalTo(138 * Constraint.yCoeff)
            make.width.equalTo(117 * Constraint.xCoeff)
        }

        todayTasksLabel.snp.remakeConstraints { make in
            make.top.equalTo(numberOfDays.snp.top)
            make.leading.equalTo(numberOfDays.snp.trailing).offset(8 * Constraint.xCoeff)
            make.height.equalTo(21 * Constraint.yCoeff)
        }

        numberOfDaysLabel.snp.remakeConstraints { make in
            make.top.equalTo(todayTasksLabel.snp.bottom)
            make.leading.equalTo(numberOfDays.snp.trailing).offset(8 * Constraint.xCoeff)
            make.height.equalTo(17 * Constraint.yCoeff)
        }

        daysCountView.snp.remakeConstraints { make in
            make.top.equalTo(numberOfDaysLabel.snp.bottom).offset(10 * Constraint.xCoeff)
            make.leading.equalTo(numberOfDays.snp.trailing).offset(8 * Constraint.xCoeff)
            make.trailing.equalTo(topViewBackground.snp.trailing).offset(-12 * Constraint.xCoeff)
            make.height.equalTo(19 * Constraint.yCoeff)
        }

        calendarView.snp.remakeConstraints { make in
            make.bottom.equalTo(numberOfDays.snp.bottom)
            make.leading.equalTo(numberOfDays.snp.trailing).offset(8 * Constraint.xCoeff)
            make.trailing.equalTo(topViewBackground.snp.trailing).offset(-12 * Constraint.xCoeff)
            make.height.equalTo(65 * Constraint.yCoeff)
        }
    }

    func makeTopViewAttributedString(for sport: String) -> NSAttributedString {
        let text = "Completed \(sport.lowercased()) out of 3 tasks"
        let attributedString = NSMutableAttributedString(string: text)

        let completedRange = (text as NSString).range(of: "Completed")
        attributedString.addAttributes([
            .foregroundColor: UIColor.whiteColor.withAlphaComponent(0.3),
            .font: UIFont.poppinsRegular(size: 11)
        ], range: completedRange)

        let sportRange = (text as NSString).range(of: sport.lowercased())
        attributedString.addAttributes([
            .foregroundColor: UIColor.whiteColor,
            .font: UIFont.poppinsBold(size: 14)
        ], range: sportRange)

        let dayRange = (text as NSString).range(of: "out of 3 tasks")
        attributedString.addAttributes([
            .foregroundColor: UIColor.whiteColor.withAlphaComponent(0.3),
            .font: UIFont.poppinsRegular(size: 11)
        ], range: dayRange)

        updateDailyViewColor(sport: Int(sport) ?? 0)
        return attributedString
    }

    func updateDailyViewColor(sport: Int) {
        daysCountView.dayOneBackground.backgroundColor = sport >= 1 ? .mainViewsBackgroundYellow : .whiteColor.withAlphaComponent(0.4)
        daysCountView.dayTwoBackground.backgroundColor = sport >= 2 ? .mainViewsBackgroundYellow : .whiteColor.withAlphaComponent(0.4)
        daysCountView.dayThreeBackground.backgroundColor = sport >= 3 ? .mainViewsBackgroundYellow : .whiteColor.withAlphaComponent(0.4)
    }
}
