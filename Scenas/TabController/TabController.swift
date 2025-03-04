//
//  TabController.swift
//  Betfair
//
//  Created by Gio's Mac on 01.03.25.
//

import UIKit

class TabController: UITabBarController,  UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor
        self.delegate = self

        navigationItem.hidesBackButton = true
        // Instantiate the three view controllers
        let tasksVC = TasksController()
        let leadersVC = LeadersController()
        let competitionVC = CompetitionController()
        let profileVC = ProfileController()

        // Create Navigation Controllers for each (optional for navigation stack)
        let tasks = UINavigationController(rootViewController: tasksVC)
        let leaders = UINavigationController(rootViewController: leadersVC)
        let competition = UINavigationController(rootViewController: competitionVC)
        let profile = UINavigationController(rootViewController: profileVC)

        tasks.navigationBar.isHidden = true
        leaders.navigationBar.isHidden = true
        competition.navigationBar.isHidden = true
        profile.navigationBar.isHidden = true

        // Configure tab bar items
        tasks.tabBarItem = UITabBarItem(
            title: "tasks",
            image: resizeImage(
                named: "tasks", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)
            ),
            tag: 0
        )
        leaders.tabBarItem = UITabBarItem(
            title: "leaders",
            image: resizeImage(named: "leaders", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)),
            tag: 1
        )
        competition.tabBarItem = UITabBarItem(
            title: "competition",
            image: resizeImage(named: "competition", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)),
            tag: 1
        )
        profile.tabBarItem = UITabBarItem(
            title: "profile",
            image: resizeImage(named: "profile", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)),
            tag: 2
        )

        // Assign view controllers to the Tab Bar
        viewControllers = [tasks, leaders, competition, profile]

        tasks.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0 * Constraint.yCoeff,
            left: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            right: 0 * Constraint.xCoeff
        )
        leaders.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0 * Constraint.yCoeff,
            left: 0,
            bottom: 0 * Constraint.yCoeff,
            right: 0
        )
        competition.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0 * Constraint.yCoeff,
            left: 0,
            bottom: 0 * Constraint.yCoeff,
            right: 0
        )
        profile.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0 * Constraint.yCoeff,
            left: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            right: 0 * Constraint.xCoeff
        )

        // Style the Tab Bar (optional)
        tabBar.tintColor = .mainViewsBackgroundYellow
        tabBar.unselectedItemTintColor = .blackColor
        tabBar.barTintColor = UIColor.blackColor
        tabBar.isTranslucent = false
    }

    private func resizeImage(named: String, size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else { return nil }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

