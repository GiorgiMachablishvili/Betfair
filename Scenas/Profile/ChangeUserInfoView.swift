//
//  ChangeUserInfoView.swift
//  Betfair
//
//  Created by Gio's Mac on 07.03.25.
//

import UIKit

class ChangeUserInfoView: UIView {

    private lazy var viewMainBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var workoutBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "profile")
        view.contentMode = .scaleAspectFill
        view.makeRoundCorners(60)
        return view
    }()

    private lazy var editButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.makeRoundCorners(12)
        view.backgroundColor = .mainViewsBackgroundYellow
        view.setTitle("Edit", for: .normal)
        view.setTitleColor(.whiteColor, for: .normal)
        return view
    }()

}
