

import UIKit
import SnapKit

class LeadersController: UIViewController {

    private let users: [UserInfo] = [
        UserInfo(image: "user1", userName: "Alice", userRating: "1200"),
        UserInfo(image: "user2", userName: "Bob", userRating: "1500"),
        UserInfo(image: "user3", userName: "Charlie", userRating: "1800")
    ]


    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 70 * Constraint.yCoeff)
        layout.minimumLineSpacing = 4
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10 * Constraint.yCoeff, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(UsersCell.self, forCellWithReuseIdentifier: "UsersCell")
        return view
    }()

    private lazy var topLeaderBoardView: TopViewLeaderBoard = {
        let view = TopViewLeaderBoard()
        return view
    }()

    private lazy var challengeView: UserChallengeView = {
        let view = UserChallengeView()
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(topLeaderBoardView)
        view.addSubview(collectionView)
        view.addSubview(challengeView)

    }

    private func setupConstraint() {
        topLeaderBoardView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(180 * Constraint.yCoeff)
        }

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(topLeaderBoardView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.bottom.trailing.equalToSuperview()
        }

        challengeView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension LeadersController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCell", for: indexPath) as? UsersCell else {
            return UICollectionViewCell()
        }
        let userInfo = users[indexPath.item]
        cell.configuration(with: userInfo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        challengeView.isHidden = false
    }
}
