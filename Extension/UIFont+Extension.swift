//
//  UIFont+Extension.swift
//  Betfair
//
//  Created by Gio's Mac on 28.02.25.
//

import UIKit

extension UIFont {
    //MARK: font extension
    static func poppinsBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? .systemFont(ofSize: size)
    }

    static func poppinsMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? .systemFont(ofSize: size)
    }

    static func poppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func poppinsThin(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Thin", size: size) ?? .systemFont(ofSize: size)
    }
}

