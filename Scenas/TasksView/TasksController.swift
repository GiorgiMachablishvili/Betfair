

import UIKit
import SnapKit

class TasksController: UIViewController {

    private var workoutTimer: Timer?
    private var countdownTimer: Timer?

    private var activeWorkoutView: UIView?

    private lazy var topView: TopView = {
        let view = TopView()
        return view
    }()

    private lazy var chooseFirstWorkoutView: ChooseFirstWorkoutView = {
        let view = ChooseFirstWorkoutView()
        view.didPressGetStartedButton = { [weak self] in
            self?.getStartFirstWorkout()
        }
        return view
    }()

    private lazy var chooseSecondWorkoutView: ChooseSecondWorkoutView = {
        let view = ChooseSecondWorkoutView()
        view.didPressGetStartedButton = { [weak self] in
            self?.getStartSecondWorkout()
        }
        return view
    }()

    private lazy var chooseThirdWorkoutView: ChooseThirdWorkoutView = {
        let view = ChooseThirdWorkoutView()
        view.didPressGetStartedButton = { [weak self] in
            self?.getStartThirdWorkout()
        }
        return view
    }()

    private lazy var timerView: TimerView = {
        let view = TimerView()
        view.didPressStartedButton = { [weak self] in
            self?.startCountdown()
        }
        view.didPressCloseButton = { [weak self] in
            self?.stopTimerAndHideView()
        }
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
        view.addSubview(topView)
        view.addSubview(chooseThirdWorkoutView)
        view.addSubview(chooseSecondWorkoutView)
        view.addSubview(chooseFirstWorkoutView)
        view.addSubview(timerView)
    }

    private func setupConstraint() {
        topView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(211 * Constraint.yCoeff)
        }

        chooseThirdWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(56 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        chooseSecondWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(72 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        chooseFirstWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(88 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        timerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func getStartFirstWorkout() {
        activeWorkoutView = chooseFirstWorkoutView
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true
        if let selectedWorkout = workouts.first(where: { $0.title == chooseFirstWorkoutView.workoutTitle.text }) {
            timerView.workoutTitle.text = selectedWorkout.title
            timerView.workoutDescription.text = "\(selectedWorkout.description) (\(selectedWorkout.duration) sec)"
            timerView.workoutNumberLabel.text = "\(selectedWorkout.duration) Sec"
        }
    }

    private func getStartSecondWorkout() {
        activeWorkoutView = chooseSecondWorkoutView
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true
        if let selectedWorkout = workouts.first(where: { $0.title == chooseSecondWorkoutView.workoutTitle.text }) {
            timerView.workoutTitle.text = selectedWorkout.title
            timerView.workoutDescription.text = "\(selectedWorkout.description) (\(selectedWorkout.duration) sec)"
            timerView.workoutNumberLabel.text = "\(selectedWorkout.duration) Sec"
        }
    }

    private func getStartThirdWorkout() {
        activeWorkoutView = chooseThirdWorkoutView
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true
        if let selectedWorkout = workouts.first(where: { $0.title == chooseThirdWorkoutView.workoutTitle.text }) {
            timerView.workoutTitle.text = selectedWorkout.title
            timerView.workoutDescription.text = "\(selectedWorkout.description) (\(selectedWorkout.duration) sec)"
            timerView.workoutNumberLabel.text = "\(selectedWorkout.duration) Sec"
        }
    }

    private func startCountdown() {
        // Stop any existing countdown timer
        countdownTimer?.invalidate()
        countdownTimer = nil

        timerView.startButton.setTitle("Reinvented", for: .normal)
        timerView.startButton.isUserInteractionEnabled = false
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)

        let countdownNumbers = ["3", "2", "1", "GO"]
        var index = 0

        // Find the correct workout based on `activeWorkoutView`
        let selectedWorkoutTitle: String?
        if activeWorkoutView == chooseFirstWorkoutView {
            selectedWorkoutTitle = chooseFirstWorkoutView.workoutTitle.text
        } else if activeWorkoutView == chooseSecondWorkoutView {
            selectedWorkoutTitle = chooseSecondWorkoutView.workoutTitle.text
        } else if activeWorkoutView == chooseThirdWorkoutView {
            selectedWorkoutTitle = chooseThirdWorkoutView.workoutTitle.text
        } else {
            selectedWorkoutTitle = nil
        }

        // Find the matching workout
        guard let workoutTitle = selectedWorkoutTitle,
              let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) else { return }

        // Start a fresh countdown
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if index < countdownNumbers.count {
                self.timerView.workoutNumberLabel.text = countdownNumbers[index]
                index += 1
            } else {
                timer.invalidate()
                self.countdownTimer = nil

                // After "GO", start the workout timer
                self.startWorkoutTimer(duration: selectedWorkout.duration)
            }
        }
    }



    private func startWorkoutTimer(duration: Int) {
        // Stop any existing workout timer before starting a new one
        workoutTimer?.invalidate()
        workoutTimer = nil

        timerView.startButton.isUserInteractionEnabled = true
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow

        var timeRemaining = duration
        timerView.workoutNumberLabel.text = "\(timeRemaining)"

        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"
            } else {
                timer.invalidate()
                self.workoutTimer = nil
                self.timerView.workoutNumberLabel.text = "✔️"
                self.timerView.workoutTitle.text = "Completed!"
                self.timerView.workoutDescription.text = "You did a great job"
                self.timerView.startButton.setTitle("Okey", for: .normal)

                self.timerView.startButton.addTarget(self, action: #selector(self.hideTimerView), for: .touchUpInside)
            }
        }
    }


    private func stopTimerAndHideView() {
        workoutTimer?.invalidate()
        countdownTimer?.invalidate()
        workoutTimer = nil
        countdownTimer = nil
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }


//    private func startWorkoutTimer() {
//        timerView.startButton.isUserInteractionEnabled = true
//        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow
//
//        guard let durationText = timerView.workoutNumberLabel.text?.components(separatedBy: " ").first,
//              let duration = Int(durationText) else { return }
//
//        var timeRemaining = duration
//        timerView.workoutNumberLabel.text = "\(timeRemaining)"
//
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"
//            } else {
//                timer.invalidate()
//                self.timerView.workoutNumberLabel.text = "✔️"
//                self.timerView.workoutTitle.text = "Completed!"
//                self.timerView.workoutDescription.text = "You did a great job"
//                self.timerView.startButton.setTitle("Okey", for: .normal)
//
//                self.timerView.startButton.addTarget(self, action: #selector(self.hideTimerView), for: .touchUpInside)
//            }
//        }
//    }
    @objc private func hideTimerView() {
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false
        activeWorkoutView?.isHidden = true
        activeWorkoutView = nil
    }
}
