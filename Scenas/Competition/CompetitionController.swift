

import UIKit
import SnapKit

class CompetitionController: UIViewController {

    private let viewModel = CompetitionViewModel()

    private var isShowingActive: Bool = true
    private var isAcceptChallengedViewVisible: Bool = false

    private var activeWorkoutCell: UICollectionViewCell?

//    private var workoutTimer: Timer?
    private var countdownTimer: Timer?

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
//            self?.activeOpponentButton()
            self?.viewModel.activeOpponentButton()
        }
        view.didPressCompletedButton = { [weak self] in
//            self?.completedButton()
            self?.viewModel.completedButton()
        }
        return view
    }()

    private lazy var timerView: TimerView = {
        let view = TimerView()
        //            view.didPressStartedButton = { [weak self] in
        ////                self?.startTimerForWorkout()
        //                self?.viewModel.startTimerForWorkout()
        //            }
        view.didPressStartedButton = { [weak self] in
            guard let self = self else { return }
            guard let cell = self.activeWorkoutCell as? AcceptChallengedCell else { return }
            let workoutTitle = cell.workoutTitle.text
            self.viewModel.startTimerForWorkout(with: workoutTitle, in: workouts)
        }
        view.didPressCloseButton = { [weak self] in
            self?.stopTimerAndHideView()
        }
        view.isHidden = true
        return view
    }()

    private lazy var doNotHaveChallengesView: DoNotHaveChallengesView = {
        let view = DoNotHaveChallengesView()
        view.isHidden = true
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
        setupBindings()
    }
    

    private func setup() {
        view.addSubview(competitionTopView)
        view.addSubview(collectionView)
        view.addSubview(timerView)
        view.addSubview(doNotHaveChallengesView)
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

        doNotHaveChallengesView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupBindings() {
        viewModel.onActiveOpponentButton = { [weak self] in
            self?.isShowingActive = true
            self?.isAcceptChallengedViewVisible = false
            self?.updateUI()
        }

        viewModel.onCompletedButton = { [weak self] in
            self?.isShowingActive = false
            self?.isAcceptChallengedViewVisible = false
            self?.updateUI()
        }

        viewModel.onHideAcceptChallengedView = { [weak self] in
            self?.isAcceptChallengedViewVisible = false
            self?.updateUI()
        }

        viewModel.onShowAcceptChallengedView = { [weak self] in
            self?.isAcceptChallengedViewVisible = true
            self?.updateUI()
        }

        viewModel.onStartTimerForWorkout = { [weak self] selectedWorkout in
            self?.handleStartWorkout(with: selectedWorkout)
        }
    }

    private func updateUI() {
        viewModel.updateButtonStyles(competitionTopView: competitionTopView)
        collectionView.reloadData()
    }

//    private func startTimerForWorkout() {
//        guard let acceptCell = activeWorkoutCell as? AcceptChallengedCell,
//              let workoutTitle = acceptCell.workoutTitle.text,
//              let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) else {
//            print("Error: No active workout selected or workout not found")
//            return
//        }
//
//        let duration = selectedWorkout.duration
//        timerView.workoutTitle.text = workoutTitle
//        timerView.workoutDescription.text = "\(selectedWorkout.description) (\(duration) Sec)"
//        timerView.workoutNumberLabel.text = "\(duration) Sec"
//        startCountdownTimer(with: duration, workoutTitle: workoutTitle)
//    }

    private func handleStartWorkout(with workout: TrainingModelCS) {
        let duration = workout.duration
        timerView.workoutTitle.text = workout.title
        timerView.workoutDescription.text = "\(workout.description) (\(duration) Sec)"
        timerView.workoutNumberLabel.text = "\(duration) Sec"
        startCountdownTimer(with: duration, workoutTitle: workout.title)
    }


    //TODO: finish mvvm pattern
    private func getTimerWorkout() {
        // Get the AcceptChallengedCell as the active workout view
        activeWorkoutCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? AcceptChallengedCell
        // Show timerView and hide the tab bar
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true
        // Ensure AcceptChallengedCell exists and extract workout details
        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell {
            let workoutTitle = acceptCell.workoutTitle.text ?? "Workout"
            // Find the workout from the list
            if let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) {
                let duration = selectedWorkout.duration
                // Update timerView with the extracted workout details
                timerView.workoutTitle.text = workoutTitle
                timerView.workoutDescription.text = "\(selectedWorkout.description) (\(duration) Sec)"
                timerView.workoutNumberLabel.text = "\(duration) Sec"

                // Start the countdown timer
                startCountdownTimer(with: duration, workoutTitle: workoutTitle)
            } else {
                print("Error: Workout not found in the list")
            }
        }
    }


    //TODO: need update correct timer number
    private func extractDuration(from text: String) -> Int {
        let words = text.components(separatedBy: " ")
        for word in words {
            if let number = Int(word) {
                return number
            }
        }
        return 30
    }

    private func startCountdownTimer(with duration: Int, workoutTitle: String) {
        countdownTimer?.invalidate()
        countdownTimer = nil

        guard let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) else {
               print("Error: Workout not found in the list")
               return
           }

        timerView.startButton.setTitle("Reinvented", for: .normal)
        timerView.startButton.isUserInteractionEnabled = false
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)

        let countdownNumbers = ["3", "2", "1", "GO"]
        var index = 0

        timerView.progressView.setProgress(to: 0)

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if index < countdownNumbers.count {
                let progress = CGFloat(index + 1) / CGFloat(countdownNumbers.count)
                UIView.animate(withDuration: 0.9) {
                    self.timerView.progressView.setProgress(to: progress)
                }
                self.timerView.workoutNumberLabel.text = countdownNumbers[index]
                index += 1
            } else {
                timer.invalidate()
                self.countdownTimer = nil
                self.startWorkoutTimer(duration: selectedWorkout.duration)
            }
        }
    }

    private func startWorkoutTimer(duration: Int) {
        countdownTimer?.invalidate()
        countdownTimer = nil

        timerView.startButton.isUserInteractionEnabled = true
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow

        var timeRemaining = duration
        timerView.workoutNumberLabel.text = "\(timeRemaining)"

        let totalDuration = CGFloat(duration)
        var elapsedTime: CGFloat = 0.0

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                elapsedTime += 1.0
                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"

                // Update circular progress
                let progress = elapsedTime / totalDuration
                self.timerView.progressView.setProgress(to: progress)
            } else {
                timer.invalidate()
                self.countdownTimer = nil
                self.timerView.workoutNumberLabel.text = "✔️"
                self.timerView.workoutTitle.text = "Completed!"
                self.timerView.workoutDescription.text = "You did a great job!"
                self.timerView.startButton.setTitle("Okay", for: .normal)

                // Ensure full progress
                self.timerView.progressView.setProgress(to: 1.0)

                // Add action to close timer view
                self.timerView.startButton.addTarget(self, action: #selector(self.hideTimerView), for: .touchUpInside)
            }
        }
    }

    private func stopTimerAndHideView() {
//        workoutTimer?.invalidate()
        countdownTimer?.invalidate()
//        workoutTimer = nil
        countdownTimer = nil
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    @objc private func hideTimerView() {
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false

        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell {
            acceptCell.loadRandomWorkout()
//            if let currentNumber = Int(acceptCell.workoutNumberLabel.text ?? "0") {
//                acceptCell.workoutNumberLabel.text = "\(currentNumber + 1)"
//            }
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
//                self?.hideAcceptChallengedView()
                self?.viewModel.hideAcceptChallengedView()
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
//                self?.showAcceptChallengedView()
                self?.viewModel.showAcceptChallengedView()
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
