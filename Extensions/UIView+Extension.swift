//
//  UIView+Extension.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit


extension UIView {
    
    func applyBlurEffect(withRadius: Bool) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        if withRadius{
            blurEffectView.clipsToBounds = true
            blurEffectView.layer.cornerRadius = 4
        }
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
