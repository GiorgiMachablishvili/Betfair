

import UIKit
import SnapKit

class LeadersController: UIViewController {

    private let users: [UserInfo] = [
        UserInfo(image: "user1", userName: "Alice", userRating: "1200"),
        UserInfo(image: "user2", userName: "Bob", userRating: "1500"),
        UserInfo(image: "user3", userName: "Charlie", userRating: "1800")
    ]

    private var filteredUsers: [UserInfo] = []

    private var isSearching: Bool = false

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
        view.didPressComplainButton = { [weak self] in
            self?.showComplainView()
        }
        view.didPressColseButton = { [weak self] in
            self?.closeChallengeView()
        }
        return view
    }()

    private lazy var complaintView: ComplaintView = {
        let view = ComplaintView()
        view.isHidden = true
        view.didPressCancelButton = { [weak self] in
            self?.closeComplaintView()
        }
        view.didPressYesToConfirmButton = { [weak self] in
            self?.confirmButton()
        }

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        filteredUsers = users

        setup()
        setupConstraint()

        topLeaderBoardView.searchUsers.delegate = self
    }

    private func setup() {
        view.addSubview(topLeaderBoardView)
        view.addSubview(collectionView)
        view.addSubview(challengeView)
        view.addSubview(complaintView)
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

        complaintView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func showComplainView() {
        challengeView.isHidden = true
        complaintView.isHidden = false
    }

    private func closeChallengeView() {
        challengeView.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }

    private func closeComplaintView() {
        challengeView.isHidden = false
        complaintView.isHidden = true
    }

    private func confirmButton() {
        //TODO: press to confirm to send complaint back end
    }
}

extension LeadersController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCell", for: indexPath) as? UsersCell else {
            return UICollectionViewCell()
        }
        let userInfo = filteredUsers[indexPath.item] // 🔹 Use filtered list
        cell.configuration(with: userInfo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        challengeView.isHidden = false
    }
}

extension LeadersController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredUsers = users
        } else {
            isSearching = true
            filteredUsers = users.filter {
                $0.userName.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData() // 🔄 Refresh the list
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        filteredUsers = users
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}
