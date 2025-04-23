

import UIKit
import SnapKit

class ComplaintView: UIView {

    var didPressCancelButton: (() -> Void)?
    var didPressYesToConfirmButton: (() -> Void)?

    private lazy var viewMainBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var complaintBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var complaintImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "complaint")
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        return view
    }()

    lazy var questionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Do you really think the user is breaking the rules ?"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    lazy var cancelButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Cancel", for: .normal)
        view.backgroundColor = UIColor.blackColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
        return view
    }()

    lazy var yesToConfirmButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Yes to confirm", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickYesToConfirmButton), for: .touchUpInside)
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
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(viewMainBackground)
        addSubview(complaintBackground)
        addSubview(complaintImage)
        addSubview(questionLabel)
        addSubview(cancelButton)
        addSubview(yesToConfirmButton)
        addSubview(closeButton)
    }

    private func setupConstraints() {
        viewMainBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        complaintBackground.snp.remakeConstraints { make in
            make.top.equalTo(viewMainBackground.snp.top).offset(360 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(340 * Constraint.yCoeff)
        }

        complaintImage.snp.remakeConstraints { make in
            make.top.equalTo(complaintBackground.snp.top).offset(32 * Constraint.yCoeff)
            make.centerX.equalTo(complaintBackground)
            make.height.width.equalTo(120 * Constraint.yCoeff)
        }

        questionLabel.snp.remakeConstraints { make in
            make.top.equalTo(complaintImage.snp.bottom).offset(24 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(48 * Constraint.xCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
        }

        cancelButton.snp.remakeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(24 * Constraint.yCoeff)
            make.leading.equalTo(complaintBackground.snp.leading).offset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }

        yesToConfirmButton.snp.remakeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(24 * Constraint.yCoeff)
            make.trailing.equalTo(complaintBackground.snp.trailing).offset(-20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.top.equalTo(complaintBackground.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

    }

    @objc private func clickCancelButton() {
        didPressCancelButton?()
    }

    @objc private func clickYesToConfirmButton() {
        didPressYesToConfirmButton?()
    }

    @objc private func clickCloseButton() {
        didPressCancelButton?()
    }
}
