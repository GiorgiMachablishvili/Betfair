

import UIKit
import SnapKit

class WinCountView: UIView {

    private var winsCount: Int = 140

    private lazy var seriesBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gayBackground
        view.makeRoundCorners(20)
        return view
    }()

    private lazy var winImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "winImage")
        view.contentMode = .scaleAspectFill
//        view.makeRoundCorners(40)
        return view
    }()

    private lazy var winLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "\(winsCount) Win"
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
        addSubview(winImage)
        addSubview(winLabel)
        addSubview(completedLabel)
    }

    private func setupConstraints() {
        seriesBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        winImage.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(seriesBackground.snp.top).offset(22 * Constraint.yCoeff)
            make.height.equalTo(82 * Constraint.yCoeff)
            make.width.equalTo(82 * Constraint.xCoeff)
        }

        winLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.bottom.equalTo(seriesBackground.snp.bottom).offset(-30 * Constraint.yCoeff)
        }

        completedLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(seriesBackground)
            make.top.equalTo(winLabel.snp.bottom)
        }
    }

}
