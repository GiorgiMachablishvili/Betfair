

import UIKit
import SnapKit

class LeadersController: UIViewController {

    private let viewModel = LeadersViewModel()

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

    private lazy var topLeaderBoardView: TopViewLeaderBoard = {
        let view = TopViewLeaderBoard()
        return view
    }()

    private lazy var challengeView: UserChallengeView = {
        let view = UserChallengeView()
        view.isHidden = true
        view.didPressComplainButton = { [weak self] in
            self?.viewModel.showComplainView()
        }
        view.didPressColseButton = { [weak self] in
            self?.viewModel.closeChallengeView()
        }
        return view
    }()

    private lazy var complaintView: ComplaintView = {
        let view = ComplaintView()
        view.isHidden = true
        view.didPressCancelButton = { [weak self] in
            self?.viewModel.closeComplaintView()
        }
        view.didPressYesToConfirmButton = { [weak self] in
            self?.viewModel.confirmButton()
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow
        setup()
        setupConstraint()
        setupBindings()
        viewModel.loadUsers()
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

    private func setupBindings() {
        viewModel.onUsersUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }

        viewModel.onShowComplainView = { [weak self] in
            self?.challengeView.isHidden = true
            self?.complaintView.isHidden = false
        }

        viewModel.onCloseChallengeView = { [weak self] in
            self?.challengeView.isHidden = true
            self?.tabBarController?.tabBar.isHidden = false
        }

        viewModel.onCloseComplaintView = { [weak self] in
            self?.challengeView.isHidden = false
            self?.complaintView.isHidden = true
        }
    }
}

extension LeadersController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredUsers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCell", for: indexPath) as? UsersCell else {
            return UICollectionViewCell()
        }
        let userInfo = viewModel.filteredUsers[indexPath.item]
        cell.configuration(with: userInfo, rank: indexPath.item + 1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = viewModel.filteredUsers[indexPath.item]
        challengeView.configure(with: selectedUser)
        tabBarController?.tabBar.isHidden = true
        challengeView.isHidden = false
    }
}

extension LeadersController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchUsers(with: searchText)
    }
}
