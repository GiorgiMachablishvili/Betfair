

import UIKit
import SnapKit

class TopViewLeaderBoard: UIView {

    private lazy var topViewBackGround: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blackColor
        view.makeRoundCorners(24)
        return view
    }()

    private lazy var todayTasksLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Leaders"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 32)
        view.textAlignment = .center
        return view
    }()

    lazy var searchUsers: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Enter the user's nickname"
        view.makeRoundCorners(16)
        view.searchBarStyle = .minimal
        view.backgroundColor = .gayBackground  // Change to your desired color
        if let textField = view.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white  // Change text color
            textField.attributedPlaceholder = NSAttributedString(
                string: "Enter the user's nickname",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.whiteColor.withAlphaComponent(0.2)]
            )
            textField.backgroundColor = .gayBackground
        }
        if let searchIconView = view.searchTextField.leftView as? UIImageView {
            searchIconView.tintColor = .mainViewsBackgroundYellow
        }
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
        addSubview(topViewBackGround)
        addSubview(todayTasksLabel)
        addSubview(searchUsers)
    }

    private func setupConstraint() {
        topViewBackGround.snp.remakeConstraints { make in
            make.bottom.equalTo(snp.top).offset(180 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(180 * Constraint.yCoeff)
        }

        todayTasksLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(topViewBackGround)
            make.top.equalTo(topViewBackGround.snp.top).offset(60 * Constraint.yCoeff)
        }

        searchUsers.snp.remakeConstraints { make in
            make.bottom.equalTo(topViewBackGround.snp.bottom).offset(-16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(24 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }
    }

}
