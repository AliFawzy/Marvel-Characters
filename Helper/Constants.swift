//
//  Constants.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

public class Constants {
    
    static let workingWIDTH = 414.0
    static let ratioFont = SCREEN_WIDTH / (CGFloat(Constants.workingWIDTH + (Device.IS_IPHONE ? 0 : 200))) //SCREEN_WIDTH //
    
    let defaultHeader = ["Content-Type":"application/json"]
    let acceptHeader = ["Accept":"application/json"]
    let multiPartHeader = ["Content-Type": "multipart/form-data"]
    let urlencodedHeader = ["Content-Type": "application/x-www-form-urlencoded"]
    
    static let domain = "http://api-testing.lamsaworld.com/"
    
    static let paginationLimit = 25
    
    static let movie_list = "v1/content/movies"
    
}
