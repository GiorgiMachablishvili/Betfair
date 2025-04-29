

import UIKit
import SnapKit


class CompetitionController: UIViewController {

    private let viewModel = CompetitionViewModel()

    private var isShowingActive: Bool = true
    private var isAcceptChallengedViewVisible: Bool = false

    private var activeWorkoutCell: UICollectionViewCell?

    private var countdownTimer: Timer?

    private var getChallengedCountdown: Int = 3
    private var sendChallengedCountdown: Int = 2
    private var completedCountdown: Int = 5

    // Replace counters with item arrays
    private var getChallengedItems: [CompetitionItem] = []
    private var sendChallengedItems: [CompetitionItem] = []
    private var completedItems: [CompetitionItem] = []

    // Diffable data source property
    private var dataSource: UICollectionViewDiffableDataSource<CompetitionSection, CompetitionItem>!

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        // No need to set dataSource - the diffable data source handles this
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
        setupDataSource()
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
            make.top.equalTo(competitionTopView.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

    // Set up the diffable data source
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CompetitionSection, CompetitionItem>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let self = self else { return nil }

            switch item {
            case .acceptChallenge:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "AcceptChallengedCell",
                    for: indexPath
                ) as? AcceptChallengedCell else {
                    return UICollectionViewCell()
                }
                cell.didPressSurrenderButton = { [weak self] in
                    self?.viewModel.hideAcceptChallengedView()
                }
                cell.didPressGetStartedButton = { [weak self] in
                    self?.getTimerWorkout()
                }
                return cell

            case .getChallenge:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "GetChallengedUserCell",
                    for: indexPath
                ) as? GetChallengedUserCell else {
                    return UICollectionViewCell()
                }
                cell.didPressRefuseButton = { [weak self] in
                    self?.handleAcceptGetChallenged(item: item)
                }
                cell.didPressAcceptButton = { [weak self] in
                    self?.viewModel.showAcceptChallengedView()
                }
                return cell

            case .sendChallenge:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "SendChallengedUserCell",
                    for: indexPath
                ) as? SendChallengedUserCell else {
                    return UICollectionViewCell()
                }
                cell.didPressCancelButton = { [weak self] in
                    self?.handleCancelSendChallenged(item: item)
                }
                return cell

            case .completed:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "CompletedCell",
                    for: indexPath
                ) as? CompletedCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
        }

        // Initialize with data
        for _ in 0..<getChallengedCountdown {
            getChallengedItems.append(.getChallenge(id: UUID()))
        }

        for _ in 0..<sendChallengedCountdown {
            sendChallengedItems.append(.sendChallenge(id: UUID()))
        }

        for _ in 0..<completedCountdown {
            completedItems.append(.completed(id: UUID()))
        }

        updateUI()
    }

    func setupBindings() {
        viewModel.onActiveOpponentButton = { [weak self] in
            self?.isShowingActive = true
            self?.isAcceptChallengedViewVisible = false
            self?.doNotHaveChallengesView.isHidden = true
            self?.collectionView.isHidden = false
            self?.updateUI()
        }

        viewModel.onCompletedButton = { [weak self] in
            self?.isShowingActive = false
            self?.isAcceptChallengedViewVisible = false
            self?.doNotHaveChallengesView.isHidden = true
            self?.collectionView.isHidden = false
            self?.updateUI()
        }

        viewModel.onHideAcceptChallengedView = { [weak self] in
            self?.isAcceptChallengedViewVisible = false
            self?.updateUI()
        }

        viewModel.onShowAcceptChallengedView = { [weak self] in
            self?.isAcceptChallengedViewVisible = true
            self?.doNotHaveChallengesView.isHidden = true
            self?.collectionView.isHidden = false
            self?.updateUI()
        }

        viewModel.onStartTimerForWorkout = { [weak self] selectedWorkout in
            self?.handleStartWorkout(with: selectedWorkout)
        }
    }

    // Update UI using diffable data source
    private func updateUI() {
        viewModel.updateButtonStyles(competitionTopView: competitionTopView)

        var snapshot = NSDiffableDataSourceSnapshot<CompetitionSection, CompetitionItem>()
        snapshot.appendSections([.main])

        if isAcceptChallengedViewVisible {
            snapshot.appendItems([.acceptChallenge], toSection: .main)
        } else if isShowingActive {
            // Combine the get and send challenged items
            let items = getChallengedItems + sendChallengedItems
            snapshot.appendItems(items, toSection: .main)
        } else {
            snapshot.appendItems(completedItems, toSection: .main)
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // Updated to work with diffable data source
    private func getTimerWorkout() {
        // Get the first visible cell if it's an AcceptChallengedCell
        if let cell = collectionView.visibleCells.first as? AcceptChallengedCell {
            activeWorkoutCell = cell
            timerView.isHidden = false
            tabBarController?.tabBar.isHidden = true

            let workoutTitle = cell.workoutTitle.text ?? "Workout"
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

    private func handleStartWorkout(with workout: TrainingModelCS) {
        let duration = workout.duration
        timerView.workoutTitle.text = workout.title
        timerView.workoutDescription.text = "\(workout.description) (\(duration) Sec)"
        timerView.workoutNumberLabel.text = "\(duration) Sec"
        startCountdownTimer(with: duration, workoutTitle: workout.title)
    }

//    private func extractDuration(from text: String) -> Int {
//        let words = text.components(separatedBy: " ")
//        for word in words {
//            if let number = Int(word) {
//                return number
//            }
//        }
//        return 30
//    }

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

    // Updated to work with diffable data source items instead of index paths
    private func handleCancelSendChallenged(item: CompetitionItem) {
        guard case .sendChallenge = item, !sendChallengedItems.isEmpty else { return }

        // Remove the item from the array
        if let index = sendChallengedItems.firstIndex(where: { $0 == item }) {
            sendChallengedItems.remove(at: index)
        }

        // Check if this is the last item
        let isLastItem = getChallengedItems.isEmpty && sendChallengedItems.isEmpty

        if isLastItem {
            // If it's the last item, show the empty state
            self.isShowingActive = false
            self.doNotHaveChallengesView.isHidden = false
            self.collectionView.isHidden = true
        }

        // Update the UI to reflect changes
        updateUI()
    }

    // Updated to work with diffable data source items instead of index paths
    private func handleAcceptGetChallenged(item: CompetitionItem) {
        guard case .getChallenge = item, !getChallengedItems.isEmpty else { return }

        // Remove the item from the array
        if let index = getChallengedItems.firstIndex(where: { $0 == item }) {
            getChallengedItems.remove(at: index)
        }

        // Check if this is the last item
        let isLastItem = getChallengedItems.isEmpty && sendChallengedItems.isEmpty

        if isLastItem {
            // If it's the last item, show the empty state
            self.isShowingActive = false
            self.doNotHaveChallengesView.isHidden = false
            self.collectionView.isHidden = true
        }

        // Update the UI to reflect changes
        updateUI()
    }
}

// Keep only the delegate methods we need, no need for UICollectionViewDataSource anymore
extension CompetitionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource.itemIdentifier(for: indexPath)

        switch item {
        case .acceptChallenge:
            return CGSize(width: collectionView.frame.width, height: 800 * Constraint.yCoeff)
        case .getChallenge, .sendChallenge:
            return CGSize(width: collectionView.frame.width, height: 410 * Constraint.yCoeff)
        case .completed:
            return CGSize(width: collectionView.frame.width, height: 410 * Constraint.yCoeff)
        case .none:
            return CGSize(width: collectionView.frame.width, height: 410 * Constraint.yCoeff)
        }
    }
}
