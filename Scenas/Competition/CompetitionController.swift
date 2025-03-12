

import UIKit
import SnapKit

class CompetitionController: UIViewController {

    private var isShowingActive: Bool = true
    private var isAcceptChallengedViewVisible: Bool = false

    private var activeWorkoutCell: UICollectionViewCell?

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

    private lazy var timerView: TimerView = {
        let view = TimerView()
//        view.didPressStartedButton = { [weak self] in
//            self?.startCountdown()
//        }
//        view.didPressCloseButton = { [weak self] in
//            self?.stopTimerAndHideView()
//        }
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
        view.addSubview(competitionTopView)
        view.addSubview(collectionView)
        view.addSubview(timerView)
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

        timerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
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
    

    private func getTimerWorkout() {
        // Set AcceptChallengedCell as the active workout view
        activeWorkoutCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? AcceptChallengedCell

        // Show the timerView and hide the tab bar
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true

        // Ensure AcceptChallengedCell exists and get workout details
        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell,
           let selectedWorkout = workouts.first(where: { $0.title == acceptCell.currentCompetitionLabel.text }) {

            // Update timerView with the workout details
            timerView.workoutTitle.text = selectedWorkout.title
            timerView.workoutDescription.text = "\(selectedWorkout.description) (\(selectedWorkout.duration) sec)"
            timerView.workoutNumberLabel.text = "\(selectedWorkout.duration) Sec"
        }
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
            cell.didPressGetStartedButton = { [weak self] in
                self?.getTimerWorkout()
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
