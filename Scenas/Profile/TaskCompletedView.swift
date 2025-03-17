

import UIKit
import SnapKit

class TaskCompletedView: UIView {

    private var tasksCount: Int = 140

    private lazy var seriesBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gayBackground
        view.makeRoundCorners(20)
        return view
    }()

    private lazy var tasksImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "pointImage")
        view.contentMode = .scaleAspectFill
//        view.makeRoundCorners(40)
        return view
    }()

    private lazy var taskLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "\(tasksCount) Task"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .center
        return view
    }()


    private lazy var completedLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "completed"
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
        addSubview(tasksImage)
        addSubview(taskLabel)
        addSubview(completedLabel)
    }

    private func setupConstraints() {
        seriesBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        tasksImage.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(seriesBackground.snp.top).offset(22 * Constraint.yCoeff)
            make.height.equalTo(52 * Constraint.yCoeff)
            make.width.equalTo(44 * Constraint.xCoeff)
        }

        taskLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.bottom.equalTo(seriesBackground.snp.bottom).offset(-30 * Constraint.yCoeff)
        }

        completedLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(taskLabel.snp.bottom)
        }
    }
}
