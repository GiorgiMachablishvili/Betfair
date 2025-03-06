

import UIKit
import SnapKit

class NumberOfDaysWorkouts: UIView {

    private lazy var workoutDaysBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gayBackground
        view.makeRoundCorners(20)
        return view
    }()

    private lazy var dailyImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "dailiImage")
        view.contentMode = .scaleAspectFill
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.attributedText = makeTopViewAttributedString(for: "120")
        view.textAlignment = .left
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
        addSubview(workoutDaysBackground)
        addSubview(dailyImage)
        addSubview(titleLabel)
    }

    private func setupConstraint() {
        workoutDaysBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        dailyImage.snp.remakeConstraints { make in
            make.top.equalTo(workoutDaysBackground.snp.top).offset(22 * Constraint.yCoeff)
            make.centerX.equalTo(workoutDaysBackground)
            make.height.equalTo(52 * Constraint.yCoeff)
            make.width.equalTo(43 * Constraint.xCoeff)
        }

        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(dailyImage.snp.bottom).offset(4 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(27 * Constraint.xCoeff)
        }
    }

    func makeTopViewAttributedString(for sport: String) -> NSAttributedString {
        let text = "\(sport.lowercased()) days \nYour series"
        let attributedString = NSMutableAttributedString(string: text)

        let sportRange = (text as NSString).range(of: sport.lowercased())
        attributedString.addAttributes([
            .foregroundColor: UIColor.whiteColor,
            .font: UIFont.poppinsBold(size: 14)
        ], range: sportRange)

        let dayRange = (text as NSString).range(of: "days")
        attributedString.addAttributes([
            .foregroundColor: UIColor.whiteColor.withAlphaComponent(0.3),
            .font: UIFont.poppinsRegular(size: 11)
        ], range: dayRange)

        let trainingRange = (text as NSString).range(of: "Your series")
        attributedString.addAttributes([
            .foregroundColor: UIColor.whiteColor.withAlphaComponent(0.3),
            .font: UIFont.poppinsRegular(size: 11)
        ], range: trainingRange)

        return attributedString
    }

}
