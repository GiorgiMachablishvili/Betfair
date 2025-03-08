

import UIKit
import SnapKit

class CompetitionController: UIViewController {

    private lazy var competitionTopView: CompetitionTopView = {
        let view = CompetitionTopView()
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

    }

    private func setupConstraint() {
        competitionTopView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(180 * Constraint.yCoeff)
        }
    }

}
