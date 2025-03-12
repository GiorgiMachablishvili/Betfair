

import UIKit
import SnapKit

class CompetitionController: UIViewController {

    private var isShowingActive: Bool = true
    private var isAcceptChallengedViewVisible: Bool = false

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 4
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(ActiveOpponentCell.self, forCellWithReuseIdentifier: "ActiveOpponentCell")
        view.register(CompletedCell.self, forCellWithReuseIdentifier: "CompletedCell")
        view.register(AcceptChallengedCell.self, forCellWithReuseIdentifier: "AcceptChallengedCell")
        return view
    }()

    private lazy var competitionTopView: CompetitionTopView = {
        let view = CompetitionTopView()
        view.didPressActiveButton = { [weak self] in
            self?.activeOpponentButton()
        }
        view.didPressCompletedButton = { [weak self] in
            self?.completedButton()
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }
    

    private func setup() {
        view.addSubview(competitionTopView)
        view.addSubview(collectionView)
//        view.addSubview(acceptChallengedView)
    }

    private func setupConstraint() {
        competitionTopView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(180 * Constraint.yCoeff)
        }

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(competitionTopView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

    private func activeOpponentButton() {
        isShowingActive = true
        isAcceptChallengedViewVisible = false
        updateUI()
    }

    private func completedButton() {
        isShowingActive = false
        isAcceptChallengedViewVisible = false
        updateUI()
    }

    private func updateUI() {
        updateButtonStyles()
        collectionView.reloadData()
    }

    private func updateButtonStyles() {
        if isShowingActive {
            competitionTopView.activeButton.backgroundColor = .white
            competitionTopView.activeButton.setTitleColor(.black, for: .normal)

            competitionTopView.completedButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            competitionTopView.completedButton.setTitleColor(.white, for: .normal)
        } else {
            competitionTopView.completedButton.backgroundColor = .white
            competitionTopView.completedButton.setTitleColor(.black, for: .normal)

            competitionTopView.activeButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            competitionTopView.activeButton.setTitleColor(.white, for: .normal)
        }
    }

    private func showAcceptChallengedView() {
        isAcceptChallengedViewVisible = true
        updateUI()
    }

    private func hideAcceptChallengedView() {
        isAcceptChallengedViewVisible = false
        updateUI()
    }
}

extension CompetitionController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isAcceptChallengedViewVisible {
            // Show AcceptChallengedCell when challenge is accepted
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcceptChallengedCell", for: indexPath) as? AcceptChallengedCell else {
                return UICollectionViewCell()
            }
            cell.didPressSurrenderButton = { [weak self] in
                self?.hideAcceptChallengedView()
            }
            return cell
        } else if isShowingActive {
            // Show ActiveOpponentCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActiveOpponentCell", for: indexPath) as? ActiveOpponentCell else {
                return UICollectionViewCell()
            }
            cell.didPressAcceptButton = { [weak self] in
                self?.showAcceptChallengedView()
            }

            return cell
        } else {
            // Show CompletedCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedCell", for: indexPath) as? CompletedCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}
