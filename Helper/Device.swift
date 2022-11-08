//
//  Device.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//


import UIKit

struct Device {
    // iDevice detection code
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5_OR_SE   = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_678       = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_678p      = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X_11      = IS_IPHONE && SCREEN_MAX_LENGTH == 812
    static let IS_IPHONE_XRMax_11MAX   = IS_IPHONE && SCREEN_MAX_LENGTH == 896
    
    static let IS_Small_IPHONE     = IS_IPHONE && SCREEN_MAX_LENGTH  < 668
    static let IS_Medium_IPHONE_Plus   = IS_IPHONE && SCREEN_MAX_LENGTH  < 737 && SCREEN_MAX_LENGTH  > 667
    static let IS_Large_IPHONE_X   = IS_IPHONE && SCREEN_MAX_LENGTH  < 813 && SCREEN_MAX_LENGTH  > 737
    
    static let IS_Greater_Than_Plus    = IS_IPHONE && SCREEN_MAX_LENGTH  > 736
    
    static let IS_IPAD_All         = IS_IPAD && SCREEN_MAX_LENGTH >= 1024
    static let IS_IPAD_PRO10       = IS_IPAD && SCREEN_MAX_LENGTH == 1112
    static let IS_IPAD_PRO12       = IS_IPAD && SCREEN_MAX_LENGTH == 1366
}
