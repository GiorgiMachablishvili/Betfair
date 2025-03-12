
import UIKit
import SnapKit

class AcceptChallengedCell: UICollectionViewCell {

    var didPressSurrenderButton: (() -> Void)?
    var didPressGetStartedButton: (() -> Void)?

    private lazy var userViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(30)
        return view
    }()

    lazy var userNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "You"
        view.textColor = UIColor.mainViewsBackgroundYellow
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var userScoreView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(14)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var userScoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "4"
        view.font = UIFont.poppinsBold(size: 14)
        view.textColor = .whiteColor
        view.textAlignment = .center
        return view
    }()

    private lazy var vsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "VS"
        view.font = UIFont.poppinsBold(size: 20)
        view.textColor = .blackColor
        view.textAlignment = .center
        return view
    }()

    private lazy var opponentImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(30)
        return view
    }()

    lazy var opponentNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "SoccerPlayer"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var opponentImageScoreView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(14)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var opponentScoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "30"
        view.font = UIFont.poppinsBold(size: 14)
        view.textColor = .whiteColor
        view.textAlignment = .center
        return view
    }()

    lazy var currentCompetitionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Current competition"
        view.font = UIFont.poppinsBold(size: 24)
        view.textColor = .blackColor
        view.textAlignment = .center
        return view
    }()

    private lazy var currentCompetitionInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = " Complete more challenges than your opponent"
        view.font = UIFont.poppinsRegular(size: 14)
        view.textColor = .blackColor
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var surrenderButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Surrender", for: .normal)
        view.backgroundColor = UIColor.blackColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickSurrenderButton), for: .touchUpInside)
        return view
    }()

    private lazy var workoutBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var yellowWhiteBackground: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "yellowWhiteBackgroound")
        return view
    }()

    private lazy var workoutNumberView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(56.5)
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var workoutNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "1"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.poppinsBold(size: 40)
        view.textAlignment = .center
        return view
    }()

    lazy var workoutTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Balance on one leg"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    lazy var workoutDescription: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.attributedText = makeTopViewAttributedString(for: "20")
        view.textAlignment = .center
        return view
    }()

    private lazy var skipButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Skip", for: .normal)
        view.backgroundColor = UIColor.blackColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickSkipButton), for: .touchUpInside)
        return view
    }()

    private lazy var getStartedButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Get started", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickGetStartedButton), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
        loadRandomWorkout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(userViewBackground)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(userScoreView)
        userScoreView.addSubview(userScoreLabel)
        addSubview(vsLabel)
        addSubview(opponentImage)
        addSubview(opponentNameLabel)
        addSubview(opponentImageScoreView)
        opponentImageScoreView.addSubview(opponentScoreLabel)
        addSubview(currentCompetitionLabel)
        addSubview(currentCompetitionInfoLabel)
        addSubview(surrenderButton)
        addSubview(workoutBackground)
        addSubview(yellowWhiteBackground)
        addSubview(workoutNumberView)
        addSubview(workoutNumberLabel)
        addSubview(workoutTitle)
        addSubview(workoutDescription)
        addSubview(skipButton)
        addSubview(getStartedButton)
    }

    private func setupConstraints() {
        userViewBackground.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(326 * Constraint.yCoeff)
        }

        yellowWhiteBackground.snp.remakeConstraints { make in
            make.leading.top.trailing.equalTo(workoutBackground)
            make.height.equalTo(212 * Constraint.yCoeff)
        }

        userImage.snp.remakeConstraints { make in
            make.top.equalTo(userViewBackground.snp.top).offset(40 * Constraint.yCoeff)
            make.leading.equalTo(userViewBackground.snp.leading).offset(40 * Constraint.xCoeff)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }

        userNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(userImage)
            make.top.equalTo(userImage.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        userScoreView.snp.remakeConstraints { make in
            make.bottom.equalTo(userImage.snp.bottom)
            make.leading.equalTo(userImage.snp.trailing).offset(15.5 * Constraint.xCoeff)
            make.height.equalTo(29 * Constraint.yCoeff)
            make.width.equalTo(34 * Constraint.xCoeff)
        }

        userScoreLabel.snp.remakeConstraints { make in
            make.center.equalTo(userScoreView)
            make.height.equalTo(21 * Constraint.yCoeff)
        }

        vsLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(userScoreView)
            make.centerX.equalTo(userViewBackground)
        }

        opponentImage.snp.remakeConstraints { make in
            make.top.equalTo(userViewBackground.snp.top).offset(40 * Constraint.yCoeff)
            make.trailing.equalTo(userViewBackground.snp.trailing).offset(-40 * Constraint.xCoeff)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }

        opponentNameLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(opponentImage)
            make.top.equalTo(opponentImage.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        opponentImageScoreView.snp.remakeConstraints { make in
            make.bottom.equalTo(opponentImage.snp.bottom)
            make.trailing.equalTo(opponentImage.snp.leading).offset(-15.5 * Constraint.xCoeff)
            make.height.equalTo(29 * Constraint.yCoeff)
            make.width.equalTo(34 * Constraint.xCoeff)
        }

        opponentScoreLabel.snp.remakeConstraints { make in
            make.center.equalTo(opponentImageScoreView)
            make.height.equalTo(21 * Constraint.yCoeff)
        }

        surrenderButton.snp.remakeConstraints { make in
            make.bottom.equalTo(userViewBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.centerX.equalTo(userViewBackground)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(318 * Constraint.xCoeff)
        }

        currentCompetitionLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(surrenderButton.snp.top).offset(-62 * Constraint.yCoeff)
            make.centerX.equalTo(userViewBackground)
        }

        currentCompetitionInfoLabel.snp.remakeConstraints { make in
            make.top.equalTo(currentCompetitionLabel.snp.bottom)
            make.centerX.equalTo(userViewBackground)
            make.width.equalTo(300 * Constraint.xCoeff)
        }

        workoutBackground.snp.makeConstraints { make in
            make.top.equalTo(userViewBackground.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(389 * Constraint.yCoeff)
        }

        workoutNumberView.snp.remakeConstraints { make in
            make.top.equalTo(workoutBackground.snp.top).offset(49 * Constraint.yCoeff)
            make.centerX.equalTo(workoutBackground)
            make.height.width.equalTo(113 * Constraint.yCoeff)
        }

        workoutNumberLabel.snp.remakeConstraints { make in
            make.center.equalTo(workoutNumberView)
        }

        workoutTitle.snp.remakeConstraints { make in
            make.top.equalTo(workoutNumberView.snp.bottom).offset(50 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
            make.height.equalTo(36 * Constraint.yCoeff)
        }

        workoutDescription.snp.remakeConstraints { make in
            make.top.equalTo(workoutTitle.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
        }

        skipButton.snp.remakeConstraints { make in
            make.bottom.equalTo(workoutBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.leading.equalTo(workoutBackground.snp.leading).offset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }

        getStartedButton.snp.remakeConstraints { make in
            make.centerY.equalTo(skipButton)
            make.trailing.equalTo(workoutBackground.snp.trailing).offset(-20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }
    }

    func makeTopViewAttributedString(for sport: String) -> NSAttributedString {
        let text = "Hold your balance for \(sport.lowercased()) seconds"
        let attributedString = NSMutableAttributedString(string: text)

        let completedRange = (text as NSString).range(of: "Hold your balance for ")
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: completedRange)

        let sportRange = (text as NSString).range(of: sport.lowercased())
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: sportRange)

        let dayRange = (text as NSString).range(of: " seconds")
        attributedString.addAttributes([
            .foregroundColor: UIColor.blackColor,
            .font: UIFont.poppinsThin(size: 14)
        ], range: dayRange)

        return attributedString
    }

    func loadRandomWorkout() {
        guard let randomWorkout = workouts.randomElement() else { return }
        workoutTitle.text = randomWorkout.title
        workoutDescription.text = "\(randomWorkout.description) (\(randomWorkout.duration) sec)"
    }

    @objc private func clickSurrenderButton() {
        didPressSurrenderButton?()
    }

    @objc private func clickSkipButton() {
        loadRandomWorkout()
    }

    @objc private func clickGetStartedButton() {
        didPressGetStartedButton?()
    }
}
