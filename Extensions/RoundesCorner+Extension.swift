//
//  RoundesCorner+Extension.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class TopSpecificRoundedCornersUIView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.roundCorners([.topLeft, .topRight], radius: 20)
    }
}

class BottomSpecificRoundedCornersUIView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.roundCorners([.bottomLeft, .bottomRight], radius: 20)
    }
}

extension CALayer {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.cornerRadius = radius
            self.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.mask = mask
        }
    }
}

class RoundedUIView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
    }
}
