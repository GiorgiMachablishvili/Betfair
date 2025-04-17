

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
            guard let self = self else { return }
            self.startWorkout(for: view)
        }
        return view
    }()

    private lazy var chooseSecondWorkoutView: ChooseSecondWorkoutView = {
        let view = ChooseSecondWorkoutView()
        view.didPressGetStartedButton = { [weak self] in
            guard let self = self else { return }
            self.startWorkout(for: view)
        }
        return view
    }()

    private lazy var chooseThirdWorkoutView: ChooseThirdWorkoutView = {
        let view = ChooseThirdWorkoutView()
        view.didPressGetStartedButton = { [weak self] in
            guard let self = self else { return }
            self.startWorkout(for: view)
        }
        return view
    }()

    private lazy var timerView: TimerView = {
        let view = TimerView()
        view.didPressStartedButton = { [weak self] in
            self?.restartCountdownFromButton()
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

//    private func restartCountdownFromButton() {
//        stopTimersOnly()
//        guard let activeView = activeWorkoutView else {
//            print("No active workout view. Cannot restart countdown.")
//            return
//        }
//        activeView.isHidden = false
//        timerView.workoutNumberLabel.text = "3"
//        timerView.workoutTitle.text = "Get Ready!"
//        timerView.workoutDescription.text = "Countdown to Start"
//        timerView.startButton.setTitle("Reinvented", for: .normal)
//        timerView.startButton.isUserInteractionEnabled = false
//        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)
//
//        startCountdown()
//    }

    private func restartCountdownFromButton() {
        stopTimersOnly()

        guard let activeView = activeWorkoutView else {
            print("No active workout view. Cannot restart countdown.")
            return
        }

        activeView.isHidden = false
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true

        timerView.workoutTitle.text = "Get Ready!"
        timerView.workoutDescription.text = "Countdown to Start"
        timerView.workoutNumberLabel.text = "3"
        timerView.progressView.setProgress(to: 0)

        timerView.startButton.setTitle("Reinvented", for: .normal)
        timerView.startButton.isUserInteractionEnabled = false
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)

        startCountdown()
    }


    private func startWorkout(for view: UIView) {
        stopTimerAndReset()
        activeWorkoutView = view
        view.isHidden = false
        timerView.isHidden = false
        tabBarController?.tabBar.isHidden = true
        startCountdown()
    }

//    private func getStartFirstWorkout() {
//        stopTimerAndReset()
//        activeWorkoutView = chooseFirstWorkoutView
//        timerView.isHidden = false
//        tabBarController?.tabBar.isHidden = true
//        startCountdown()
//    }
//
//    private func getStartSecondWorkout() {
//        stopTimerAndReset()
//        activeWorkoutView = chooseSecondWorkoutView
//        activeWorkoutView?.isHidden = false
//        timerView.isHidden = false
//        tabBarController?.tabBar.isHidden = true
//        startCountdown()
//    }
//
//
//    private func getStartThirdWorkout() {
//        stopTimerAndReset()
//        activeWorkoutView = chooseThirdWorkoutView
//        timerView.isHidden = false
//        tabBarController?.tabBar.isHidden = true
//        startCountdown()
//    }

    private func startCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil

        activeWorkoutView?.isHidden = false

        let countdownNumbers = ["3", "2", "1", "GO"]
        var index = 0

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

        guard let workoutTitle = selectedWorkoutTitle,
              let selectedWorkout = workouts.first(where: { $0.title == workoutTitle }) else { return }

        timerView.workoutTitle.text = selectedWorkout.title
        timerView.workoutDescription.text = "\(selectedWorkout.description) (\(selectedWorkout.duration) sec)"
        timerView.workoutNumberLabel.text = "\(selectedWorkout.duration) Sec"
        timerView.progressView.setProgress(to: 0)
        timerView.startButton.setTitle("Reinvented", for: .normal)
        timerView.startButton.isUserInteractionEnabled = false
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow.withAlphaComponent(0.3)

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

    private func stopTimersOnly() {
        workoutTimer?.invalidate()
        countdownTimer?.invalidate()
        workoutTimer = nil
        countdownTimer = nil
    }

    private func stopTimerAndReset() {
        stopTimersOnly()
        timerView.progressView.setProgress(to: 0)
        timerView.workoutNumberLabel.text = "3"
        timerView.workoutTitle.text = "Get Ready!"
        timerView.workoutDescription.text = "Countdown to Start"
        timerView.startButton.setTitle("Start", for: .normal)
        timerView.startButton.isUserInteractionEnabled = true
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow

        activeWorkoutView?.isHidden = false
//        activeWorkoutView = nil
    }

    private func startWorkoutTimer(duration: Int) {
        workoutTimer?.invalidate()
        workoutTimer = nil

        timerView.startButton.isUserInteractionEnabled = true
        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow

        var timeRemaining = duration
        timerView.workoutNumberLabel.text = "\(timeRemaining)"
        timerView.progressView.setProgress(to: 1.0)

        let totalDuration = CGFloat(duration)
        var elapsedTime: CGFloat = 0.0

        // Unified button behavior
        timerView.didPressStartedButton = { [weak self] in
            guard let self = self else { return }

            let currentTitle = self.timerView.startButton.title(for: .normal)

            if currentTitle == "Okey" {
                self.hideTimerView()
            } else if currentTitle == "Reinvented" {
                self.restartCountdownFromButton()
            }
        }

        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                elapsedTime += 1.0
                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"

                let progress = elapsedTime / totalDuration
                self.timerView.progressView.setProgress(to: progress)
            } else {
                timer.invalidate()
                self.workoutTimer = nil

                self.timerView.workoutNumberLabel.text = "✔️"
                self.timerView.workoutTitle.text = "Completed!"
                self.timerView.workoutDescription.text = "You did a great job"
                self.timerView.startButton.setTitle("Okey", for: .normal)
                self.timerView.startButton.isUserInteractionEnabled = true
                self.timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow
            }
        }
    }


//    private func startWorkoutTimer(duration: Int) {
//        workoutTimer?.invalidate()
//        workoutTimer = nil
//
//        timerView.startButton.isUserInteractionEnabled = true
//        timerView.startButton.backgroundColor = UIColor.mainViewsBackgroundYellow
//
//        var timeRemaining = duration
//        timerView.workoutNumberLabel.text = "\(timeRemaining)"
//
//        timerView.progressView.setProgress(to: 1.0)
//
//        let totalDuration = CGFloat(duration)
//        var elapsedTime: CGFloat = 0.0
//
//        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//                elapsedTime += 1.0
//                self.timerView.workoutNumberLabel.text = "\(timeRemaining)"
//
//                let progress = elapsedTime / totalDuration
//                self.timerView.progressView.setProgress(to: progress)
//            } else {
//                timer.invalidate()
//                self.workoutTimer = nil
//                self.timerView.workoutNumberLabel.text = "✔️"
//                self.timerView.workoutTitle.text = "Completed!"
//                self.timerView.workoutDescription.text = "You did a great job"
////                self.timerView.startButton.setTitle("Okey", for: .normal)
////                self.timerView.startButton.addTarget(self, action: #selector(self.hideTimerView), for: .touchUpInside)
//                self.timerView.startButton.setTitle("Okey", for: .normal)
//                self.timerView.didPressStartedButton = { [weak self] in
//                    self?.hideTimerView()
//                }
//            }
//        }
//    }

    private func stopTimerAndHideView() {
        stopTimersOnly()
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    @objc private func hideTimerView() {
        timerView.isHidden = true
        tabBarController?.tabBar.isHidden = false
        activeWorkoutView?.isHidden = true
        activeWorkoutView = nil
    }
}
