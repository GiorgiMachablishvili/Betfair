

import UIKit
import SnapKit

class Onboarding: UIViewController {

    private var currentIndex = 0

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: "OnBoardingCell")
        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Next", for: .normal)
        view.backgroundColor = UIColor.blackColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.tintColor = UIColor.whiteColor
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickNextButton), for: .touchUpInside)
        return view
    }()

    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = onboardingView.count
        view.currentPage = 0
        view.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
        view.currentPageIndicatorTintColor = UIColor.whiteColor
        return view
    }()

    private lazy var beforeStartView: OnboardingBeforeStartView = {
        let view = OnboardingBeforeStartView()
        view.isHidden = true
        view.didPressAcceptButton = { [weak self] in
            self?.acceptAndGoTabController()
        }
        view.didPressCloseButton = { [weak self] in
            self?.hideBeforeStartView()
        }
        return view
    }()

    let onboardingView: [OnboardingView] = [
        OnboardingView(
            image: "onboarding1",
            title: "Your way to better shape!",
            viewInfo: "Every day is a new challenge. Maintain your impact mode and get stronger!"
        ),
        OnboardingView(
            image: "onboarding2",
            title: "How does it work?",
            viewInfo: "Every day you get new tasks. Complete them, earn points and compete with other users."
        ),
        OnboardingView(
            image: "onboarging3",
            title: "The main thing is to stay on top of it!",
            viewInfo: "Every day is a new challenge. If you miss a day, the series resets!"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(beforeStartView)
    }

    private func setupConstraint() {
        collectionView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(700 * Constraint.yCoeff)
        }

        nextButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(40 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

        pageControl.snp.remakeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        beforeStartView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func acceptAndGoTabController() {
        let tabBarController = TabController()
        navigationController?.pushViewController(tabBarController, animated: true)
    }

    private func hideBeforeStartView() {
        beforeStartView.isHidden = true
    }

    @objc private func clickNextButton() {
        if currentIndex < onboardingView.count - 1 {
            currentIndex += 1
            let indexPath = IndexPath(item: currentIndex, section: 0)

            // Temporarily disable paging to allow smooth scrolling
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.collectionView.isPagingEnabled = true
            }

            pageControl.currentPage = currentIndex
        } else {
            beforeStartView.isHidden = false
            print("Onboarding finished!")
        }
        updateNextButtonTitle()
    }



    private func updateNextButtonTitle() {
        let isLastPage = currentIndex == onboardingView.count - 1
        nextButton.setTitle(isLastPage ? "Start" : "Next", for: .normal)
    }
}

extension Onboarding: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingView.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCell", for: indexPath) as? OnBoardingCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: onboardingView[indexPath.item])
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentIndex = pageIndex
        pageControl.currentPage = pageIndex
        updateNextButtonTitle()
    }
}
