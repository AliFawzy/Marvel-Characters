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
    
    static let public_key = "c8c83cdaa5d309e8af31d5ffe1bb0ec5"
    static let private_key = "1efdb85217a3b8a7ca69003b3bf6e6b76ca629c8"
    
    static let domain = "http://gateway.marvel.com/"
    
    static let paginationLimit = 20
    
    static let characters = "v1/public/characters"
    
}
