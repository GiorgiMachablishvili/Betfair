//
//  ComplaintView.swift
//  Betfair
//
//  Created by Gio's Mac on 06.03.25.
//

import UIKit

class ComplaintView: UIView {

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

    lazy var userNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "SoccerPlayer"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    lazy var cancelButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Cancel", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
        return view
    }()

    lazy var yesToConfirmButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Yes to confirm", for: .normal)
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickYesToConfirmButton), for: .touchUpInside)
        return view
    }()

}
