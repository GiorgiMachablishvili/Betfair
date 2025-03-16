

import UIKit
import SnapKit

class ChangeUserInfoView: UIView {

    var didPressUserImageButton: (() -> Void)?
    var didPressSaveButton: (() -> Void)?
    var didPressCancelButton: (() -> Void)?

    var nickname: String?

    var selectedImage: UIImage? {
        didSet {
            userImageButton.setImage(selectedImage, for: .normal)
        }
    }

    private lazy var viewMainBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var changeInfoBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    lazy var userImageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "profile"), for: .normal)
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(60)
        view.addTarget(self, action: #selector(clickUserImageButton), for: .touchUpInside)
        return view
    }()

    private lazy var editInfoButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.makeRoundCorners(12)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.setTitle("Edit", for: .normal)
        view.setTitleColor(.whiteColor, for: .normal)
        view.addTarget(self, action: #selector(clickUserImageButton), for: .touchUpInside)
        return view
    }()

    lazy var nameTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.textColor = .blackColor
        view.placeholder = "Nickname"
        view.backgroundColor = .gayBackground.withAlphaComponent(0.15)
        view.font = UIFont.poppinsBold(size: 12)
        view.textAlignment = .center
        view.makeRoundCorners(20)
        return view
    }()

    lazy var saveButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Save", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickSaveButton), for: .touchUpInside)
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
        addSubview(changeInfoBackground)
        addSubview(userImageButton)
        addSubview(editInfoButton)
        addSubview(nameTextField)
        addSubview(saveButton)
        addSubview(closeButton)
    }

    private func setupConstraints() {
        viewMainBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        changeInfoBackground.snp.remakeConstraints { make in
            make.top.equalTo(viewMainBackground.snp.top).offset(427 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(309 * Constraint.yCoeff)
        }

        userImageButton.snp.remakeConstraints { make in
            make.centerX.equalTo(changeInfoBackground)
            make.top.equalTo(changeInfoBackground.snp.top).offset(32 * Constraint.yCoeff)
            make.height.width.equalTo(120 * Constraint.yCoeff)
        }

        editInfoButton.snp.remakeConstraints { make in
            make.top.equalTo(userImageButton.snp.top).offset(94 * Constraint.yCoeff)
            make.trailing.equalTo(userImageButton.snp.trailing)
            make.height.equalTo(26 * Constraint.yCoeff)
            make.width.equalTo(46 * Constraint.xCoeff)
        }

        nameTextField.snp.remakeConstraints { make in
            make.top.equalTo(userImageButton.snp.bottom).offset(11 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(32 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
        }

        saveButton.snp.remakeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(32 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.top.equalTo(changeInfoBackground.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }
    }

    @objc private func clickUserImageButton() {
        didPressUserImageButton?()

    }

    @objc private func clickSaveButton() {
        didPressSaveButton?()
    }

    @objc private func clickCloseButton() {
        didPressCancelButton?()
    }
}
