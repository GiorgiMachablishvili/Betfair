

import UIKit
import SnapKit

class ActiveOpponentCell: UICollectionViewCell {

    var didPressAcceptButton: (() -> Void)? {
        get { getChallengedUserView.didPressAcceptButton }
        set { getChallengedUserView.didPressAcceptButton = newValue }
    }

    private lazy var getChallengedUserView: GetChallengedUserView = {
        let view = GetChallengedUserView()
        return view
    }()

    private lazy var SendChallengedCurrentUserView: SendChallengedUserView = {
        let view = SendChallengedUserView()
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
        addSubview(getChallengedUserView)
        addSubview(SendChallengedCurrentUserView)
    }

    private func setupConstraint() {
        getChallengedUserView.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(410 * Constraint.yCoeff)
        }

        SendChallengedCurrentUserView.snp.remakeConstraints { make in
            make.top.equalTo(getChallengedUserView.snp.bottom).offset(16 *  Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(410 * Constraint.yCoeff)
        }
    }
}

