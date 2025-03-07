

import UIKit
import SnapKit

class ProfileController: UIViewController {

    private var users: [UserInfo] = [
        UserInfo(image: "user1", userName: "Alice", userRating: "1200"),
        UserInfo(image: "user2", userName: "Bob", userRating: "1500"),
        UserInfo(image: "user3", userName: "Charlie", userRating: "1800"),
        UserInfo(image: "user4", userName: "Tom", userRating: "900"),
        UserInfo(image: "user5", userName: "Non", userRating: "1000"),
        UserInfo(image: "user6", userName: "Tat", userRating: "700")
    ]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 70 * Constraint.yCoeff)
        layout.minimumLineSpacing = 4
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(UsersCell.self, forCellWithReuseIdentifier: "UsersCell")
        return view
    }()

    private lazy var topView: ProfileTopView = {
        let view = ProfileTopView()
        view.didPressProfileAddButton = { [weak self] in
            self?.showChangeUserInfoView()
        }
        return view
    }()

    private lazy var seriesDayView: SeriesDayView = {
        let view = SeriesDayView()
        return view
    }()

    private lazy var taskCompletedView: TaskCompletedView = {
        let view = TaskCompletedView()
        return view
    }()

    private lazy var winCountView: WinCountView = {
        let view = WinCountView()
        return view
    }()

    private lazy var changeUserInfoView: ChangeUserInfoView = {
        let view = ChangeUserInfoView()
        view.isHidden = true
        view.didPressUserImageButton = { [weak self] in
            self?.updateUserInfo()
        }
        view.didPressCancelButton = { [weak self] in
            self?.hideChangeUserInfoView()
        }
        return view
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraints()
    }

    private func setup() {
        view.addSubview(topView)
        view.addSubview(collectionView)
        view.addSubview(seriesDayView)
        view.addSubview(taskCompletedView)
        view.addSubview(winCountView)
        view.addSubview(changeUserInfoView)
    }

    private func setupConstraints() {
        topView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(156 * Constraint.yCoeff)
        }

        seriesDayView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(12 * Constraint.xCoeff)
            make.height.equalTo(138 * Constraint.yCoeff)
            make.width.equalTo(117 * Constraint.xCoeff)
        }

        taskCompletedView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(138 * Constraint.yCoeff)
            make.width.equalTo(117 * Constraint.xCoeff)
        }

        winCountView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.trailing.equalTo(view.snp.trailing).offset(-12 * Constraint.xCoeff)
            make.height.equalTo(138 * Constraint.yCoeff)
            make.width.equalTo(117 * Constraint.xCoeff)
        }

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(winCountView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.bottom.trailing.equalToSuperview()
        }

        changeUserInfoView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc private func updateUserInfo() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
//        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
//            print("userId not found or not an Int")
//            return
//        }
//        // Get the selected image and nickname from the profile view
//        let selectedImage = changeUserInfoView.selectedImage
//        let nickname = changeUserInfoView.nameTextField.text
//
//        // Show loading indicator
//        NetworkManager.shared.showProgressHud(true, animated: true)
//
//        // Send the PATCH request
//        NetworkManager.shared.updateUserProfile(userId: userId, image: selectedImage, nickname: nickname) { [weak self] result in
//            guard let self = self else { return }
//
//            DispatchQueue.main.async {
//                NetworkManager.shared.showProgressHud(false, animated: false)
//            }
//
//            switch result {
//            case .success(let userData):
//                // Update the UI with the new user data
//                self.userData = userData
//                DispatchQueue.main.async {
//                    self.hideView() // Hide the edit profile view
//                    self.collectionView.reloadData()
//                }
//            case .failure(let error):
//                print("Failed to update user profile: \(error)")
//                // Show an error message to the user
//                self.showAlert(title: "Error", message: "Failed to update profile. Please try again.")
//            }
//        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func showChangeUserInfoView() {
        tabBarController?.tabBar.isHidden = true
        changeUserInfoView.isHidden = false
    }

    private func hideChangeUserInfoView() {
        tabBarController?.tabBar.isHidden = false
        changeUserInfoView.isHidden = true
    }
}

extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCell", for: indexPath) as? UsersCell else {
            return UICollectionViewCell()
        }
        let userInfo = users[indexPath.item]
        cell.configuration(with: userInfo, rank: indexPath.item + 1)
        return cell
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            changeUserInfoView.userImageButton.setImage(UIImage(named: "\(selectedImage)"), for: .normal) // Update the image view
            changeUserInfoView.selectedImage = selectedImage // Store the selected image
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
