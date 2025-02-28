//
//  UICornerRadius.swift
//  Betfair
//
//  Created by Gio's Mac on 28.02.25.
//

import UIKit

extension UIView {
    func makeRoundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius  * Constraint.xCoeff
        self.layer.masksToBounds = true
    }
}

