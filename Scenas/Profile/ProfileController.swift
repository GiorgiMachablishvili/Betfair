

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
