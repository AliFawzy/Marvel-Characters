//
//  BaseNC.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class HomeNC: UINavigationController {
    //MARK:- Orientation
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        return UIInterfaceOrientation.portrait
    }
    // status bar status color
    public var requiredStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        requiredStatusBarStyle
    }
    let mainColor =  #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
    //MARK:- LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = mainColor
        navigationBar.backgroundColor = mainColor
        navigationBar.prefersLargeTitles = true
        isNavigationBarHidden = false
        navigationBar.shadowImage = UIImage()
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white,
            .font : semiBoldFont(18)
        ]
        let largeTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white,
            .font : semiBoldFont(18)
        ]
        self.navigationBar.titleTextAttributes = textAttributes
        self.navigationBar.largeTitleTextAttributes = largeTextAttributes
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationBar.backItem?.title = ""
        changeBarApperanceStyle(navC: self,
                                color: mainColor,
                                clearShadowColor: true)
    }
}

func semiBoldFont(_ size:CGFloat) ->UIFont {
    let fontName = "Arial"
    return UIFont(name: fontName, size: size * Constants.ratioFont)!
}

func changeBarApperanceStyle(navC: UINavigationController,
                             color: UIColor, clearShadowColor: Bool = true) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    if clearShadowColor{
        appearance.shadowColor = .clear
    }
    appearance.backgroundColor = color
    // This will alter the navigation bar title appearance
    let font = UIFont.systemFont(ofSize: 15, weight: .medium)
    let titleAttribute = [NSAttributedString.Key.font: font , NSAttributedString.Key.foregroundColor: UIColor(named: "#FFFFFF")] //alter to fit your needs
    appearance.titleTextAttributes = titleAttribute as [NSAttributedString.Key : Any]
    navC.navigationBar.standardAppearance = appearance
    navC.navigationBar.scrollEdgeAppearance = appearance
    navC.navigationBar.compactAppearance = appearance
}
