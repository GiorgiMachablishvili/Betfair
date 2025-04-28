

import UIKit
import SnapKit

class CompetitionController: UIViewController {

    private let viewModel = CompetitionViewModel()

    private var isShowingActive: Bool = true
    private var isAcceptChallengedViewVisible: Bool = false

    private var activeWorkoutCell: UICollectionViewCell?

    private var countdownTimer: Timer?

    private var getChallengedCount: Int = 5
    private var sendChallengedCount: Int = 2

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(GetChallengedUserCell.self, forCellWithReuseIdentifier: "GetChallengedUserCell")
        view.register(SendChallengedUserCell.self, forCellWithReuseIdentifier: "SendChallengedUserCell")
        view.register(CompletedCell.self, forCellWithReuseIdentifier: "CompletedCell")
        view.register(AcceptChallengedCell.self, forCellWithReuseIdentifier: "AcceptChallengedCell")
        return view
    }()

    private lazy var competitionTopView: CompetitionTopView = {
        let view = CompetitionTopView()
        view.didPressActiveButton = { [weak self] in
            self?.viewModel.activeOpponentButton()
        }
        view.didPressCompletedButton = { [weak self] in
            self?.viewModel.completedButton()
        }
        return view
    }()

    private lazy var timerView: TimerView = {
        let view = TimerView()
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

    private func handleStartWorkout(with workout: TrainingModelCS) {
        let duration = workout.duration
        timerView.workoutTitle.text = workout.title
        timerView.workoutDescription.text = "\(workout.description) (\(duration) Sec)"
        timerView.workoutNumberLabel.text = "\(duration) Sec"
        startCountdownTimer(with: duration, workoutTitle: workout.title)
    }


    //TODO: finish mvvm pattern
    private func getTimerWorkout() {
        activeWorkoutCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? AcceptChallengedCell
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true
        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell {
            let workoutTitle = acceptCell.workoutTitle.text ?? "Workout"
            if let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) {
                let duration = selectedWorkout.duration
                timerView.workoutTitle.text = workoutTitle
                timerView.workoutDescription.text = "\(selectedWorkout.description) (\(duration) Sec)"
                timerView.workoutNumberLabel.text = "\(duration) Sec"

                startCountdownTimer(with: duration, workoutTitle: workoutTitle)
            } else {
                print("Error: Workout not found in the list")
            }
        }
    }

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

                self.timerView.progressView.setProgress(to: 1.0)

                self.timerView.startButton.addTarget(self, action: #selector(self.hideTimerView), for: .touchUpInside)
            }
        }
    }

    private func stopTimerAndHideView() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    @objc private func hideTimerView() {
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false

        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell {
            acceptCell.loadRandomWorkout()
        }
    }
}

extension CompetitionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isAcceptChallengedViewVisible {
            return 1
        } else if isShowingActive {
            return getChallengedCount + sendChallengedCount
        } else {
            return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isAcceptChallengedViewVisible {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcceptChallengedCell", for: indexPath) as? AcceptChallengedCell else {
                return UICollectionViewCell()
            }
            cell.didPressSurrenderButton = { [weak self] in
                self?.viewModel.hideAcceptChallengedView()
            }
            cell.didPressGetStartedButton = { [weak self] in
                self?.getTimerWorkout()
            }
            return cell
        } else if isShowingActive {
            if indexPath.item < getChallengedCount {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetChallengedUserCell", for: indexPath) as? GetChallengedUserCell else {
                    return UICollectionViewCell()
                }
                cell.didPressAcceptButton = { [weak self] in
                    self?.viewModel.showAcceptChallengedView()
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SendChallengedUserCell", for: indexPath) as? SendChallengedUserCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedCell", for: indexPath) as? CompletedCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isAcceptChallengedViewVisible {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if isShowingActive {
            return CGSize(width: collectionView.frame.width, height: 410 * Constraint.yCoeff)
        } else {
            return CGSize(width: collectionView.frame.width, height: 410 * Constraint.yCoeff)
        }
    }
}


//
//class CompetitionController: UIViewController {
//
//    private let viewModel = CompetitionViewModel()
//
//    private var isShowingActive: Bool = true
//    private var isAcceptChallengedViewVisible: Bool = false
//
//    private var activeWorkoutCell: UICollectionViewCell?
//
//    private var countdownTimer: Timer?
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
//        layout.minimumLineSpacing = 4
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.backgroundColor = .clear
//        view.showsVerticalScrollIndicator = false
//        view.dataSource = self
//        view.delegate = self
//        view.register(ActiveOpponentCell.self, forCellWithReuseIdentifier: "ActiveOpponentCell")
//        view.register(CompletedCell.self, forCellWithReuseIdentifier: "CompletedCell")
//        view.register(AcceptChallengedCell.self, forCellWithReuseIdentifier: "AcceptChallengedCell")
//        return view
//    }()
//
//    private lazy var competitionTopView: CompetitionTopView = {
//        let view = CompetitionTopView()
//        view.didPressActiveButton = { [weak self] in
//            self?.viewModel.activeOpponentButton()
//        }
//        view.didPressCompletedButton = { [weak self] in
//            self?.viewModel.completedButton()
//        }
//        return view
//    }()
//
//    private lazy var timerView: TimerView = {
//        let view = TimerView()
//        view.didPressStartedButton = { [weak self] in
//            guard let self = self else { return }
//            guard let cell = self.activeWorkoutCell as? AcceptChallengedCell else { return }
//            let workoutTitle = cell.workoutTitle.text
//            self.viewModel.startTimerForWorkout(with: workoutTitle, in: workouts)
//        }
//        view.didPressCloseButton = { [weak self] in
//            self?.stopTimerAndHideView()
//        }
//        view.isHidden = true
//        return view
//    }()
//
//    private lazy var doNotHaveChallengesView: DoNotHaveChallengesView = {
//        let view = DoNotHaveChallengesView()
//        view.isHidden = true
//        return view
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .mainViewsBackgroundYellow
//
//        setup()
//        setupConstraint()
//        setupBindings()
//    }
//
//
//    private func setup() {
//        view.addSubview(competitionTopView)
//        view.addSubview(collectionView)
//        view.addSubview(timerView)
//        view.addSubview(doNotHaveChallengesView)
//    }
//
//    private func setupConstraint() {
//        competitionTopView.snp.remakeConstraints { make in
//            make.leading.top.trailing.equalToSuperview()
//            make.height.equalTo(180 * Constraint.yCoeff)
//        }
//
//        collectionView.snp.remakeConstraints { make in
//            make.top.equalTo(competitionTopView.snp.bottom).offset(16 * Constraint.yCoeff)
//            make.leading.bottom.trailing.equalToSuperview()
//        }
//
//        timerView.snp.remakeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        doNotHaveChallengesView.snp.remakeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//
//    func setupBindings() {
//        viewModel.onActiveOpponentButton = { [weak self] in
//            self?.isShowingActive = true
//            self?.isAcceptChallengedViewVisible = false
//            self?.updateUI()
//        }
//
//        viewModel.onCompletedButton = { [weak self] in
//            self?.isShowingActive = false
//            self?.isAcceptChallengedViewVisible = false
//            self?.updateUI()
//        }
//
//        viewModel.onHideAcceptChallengedView = { [weak self] in
//            self?.isAcceptChallengedViewVisible = false
//            self?.updateUI()
//        }
//
//        viewModel.onShowAcceptChallengedView = { [weak self] in
//            self?.isAcceptChallengedViewVisible = true
//            self?.updateUI()
//        }
//
//        viewModel.onStartTimerForWorkout = { [weak self] selectedWorkout in
//            self?.handleStartWorkout(with: selectedWorkout)
//        }
//    }
//
//    private func updateUI() {
//        viewModel.updateButtonStyles(competitionTopView: competitionTopView)
//        collectionView.reloadData()
//    }
//
//    private func handleStartWorkout(with workout: TrainingModelCS) {
//        let duration = workout.duration
//        timerView.workoutTitle.text = workout.title
//        timerView.workoutDescription.text = "\(workout.description) (\(duration) Sec)"
//        timerView.workoutNumberLabel.text = "\(duration) Sec"
//        startCountdownTimer(with: duration, workoutTitle: workout.title)
//    }
//
//
//    //TODO: finish mvvm pattern
//    private func getTimerWorkout() {
//        activeWorkoutCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? AcceptChallengedCell
//        timerView.isHidden = false
//        tabBarController?.tabBar.isHidden = true
//        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell {
//            let workoutTitle = acceptCell.workoutTitle.text ?? "Workout"
//            if let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) {
//                let duration = selectedWorkout.duration
//                timerView.workoutTitle.text = workoutTitle
//                timerView.workoutDescription.text = "\(selectedWorkout.description) (\(duration) Sec)"
//                timerView.workoutNumberLabel.text = "\(duration) Sec"
//
//                startCountdownTimer(with: duration, workoutTitle: workoutTitle)
//            } else {
//                print("Error: Workout not found in the list")
//            }
//        }
//    }
//
//    private func extractDuration(from text: String) -> Int {
//        let words = text.components(separatedBy: " ")
//        for word in words {
//            if let number = Int(word) {
//                return number
//            }
//        }
//        return 30
//    }
//
//    private func startCountdownTimer(with duration: Int, workoutTitle: String) {
//        countdownTimer?.invalidate()
//        countdownTimer = nil
//
//        guard let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) else {
//               print("Error: Workout not found in the list")
//               return
//           }
//
//        timerView.startButton.setTitle("Reinvented", for: .normal)
//        timerView.startButton.isUserInteractionEnabled = false
//        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)
//
//        let countdownNumbers = ["3", "2", "1", "GO"]
//        var index = 0
//
//        timerView.progressView.setProgress(to: 0)
//
//        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            if index < countdownNumbers.count {
//                let progress = CGFloat(index + 1) / CGFloat(countdownNumbers.count)
//                UIView.animate(withDuration: 0.9) {
//                    self.timerView.progressView.setProgress(to: progress)
//                }
//                self.timerView.workoutNumberLabel.text = countdownNumbers[index]
//                index += 1
//            } else {
//                timer.invalidate()
//                self.countdownTimer = nil
//                self.startWorkoutTimer(duration: selectedWorkout.duration)
//            }
//        }
//    }
//
//    private func startWorkoutTimer(duration: Int) {
//        countdownTimer?.invalidate()
//        countdownTimer = nil
//
//        timerView.startButton.isUserInteractionEnabled = true
//        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow
//
//        var timeRemaining = duration
//        timerView.workoutNumberLabel.text = "\(timeRemaining)"
//
//        let totalDuration = CGFloat(duration)
//        var elapsedTime: CGFloat = 0.0
//
//        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//                elapsedTime += 1.0
//                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"
//
//                // Update circular progress
//                let progress = elapsedTime / totalDuration
//                self.timerView.progressView.setProgress(to: progress)
//            } else {
//                timer.invalidate()
//                self.countdownTimer = nil
//                self.timerView.workoutNumberLabel.text = "✔️"
//                self.timerView.workoutTitle.text = "Completed!"
//                self.timerView.workoutDescription.text = "You did a great job!"
//                self.timerView.startButton.setTitle("Okay", for: .normal)
//
//                self.timerView.progressView.setProgress(to: 1.0)
//
//                self.timerView.startButton.addTarget(self, action: #selector(self.hideTimerView), for: .touchUpInside)
//            }
//        }
//    }
//
//    private func stopTimerAndHideView() {
//        countdownTimer?.invalidate()
//        countdownTimer = nil
//        timerView.isHidden = true
//        tabBarController?.tabBar.isHidden = false
//    }
//
//    @objc private func hideTimerView() {
//        timerView.isHidden = true
//        tabBarController?.tabBar.isHidden = false
//
//        if let acceptCell = activeWorkoutCell as? AcceptChallengedCell {
//            acceptCell.loadRandomWorkout()
//        }
//    }
//}
//
//extension CompetitionController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            if isAcceptChallengedViewVisible {
//                return 1
//            } else if isShowingActive {
//                return 1
//            } else {
//                return 3
//            }
//        default:
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//        case 0:
//            if isAcceptChallengedViewVisible {
//                // AcceptChallengedCell
//                guard let cell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: "AcceptChallengedCell",
//                    for: indexPath
//                ) as? AcceptChallengedCell else {
//                    return UICollectionViewCell()
//                }
//                cell.didPressSurrenderButton = { [weak self] in
//                    self?.viewModel.hideAcceptChallengedView()
//                }
//                cell.didPressGetStartedButton = { [weak self] in
//                    self?.getTimerWorkout()
//                }
//                return cell
//
//            } else if isShowingActive {
//                // ActiveOpponentCell
//                guard let cell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: "ActiveOpponentCell",
//                    for: indexPath
//                ) as? ActiveOpponentCell else {
//                    return UICollectionViewCell()
//                }
//                cell.didPressAcceptButton = { [weak self] in
//                    self?.viewModel.showAcceptChallengedView()
//                }
//                cell.configure(getChallengedCount: 3, sendChallengedCount: 2)
//                return cell
//
//            } else {
//                // CompletedCell
//                guard let cell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: "CompletedCell",
//                    for: indexPath
//                ) as? CompletedCell else {
//                    return UICollectionViewCell()
//                }
//                // here you can configure CompletedCell for different indexPath.item (if needed)
//                return cell
//            }
//
//        default:
//            return UICollectionViewCell()
//        }
//    }
//}
