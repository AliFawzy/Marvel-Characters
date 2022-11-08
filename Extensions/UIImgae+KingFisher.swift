//
//  UIImgae+KingFisher.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWith(stringUrl: String, roundedCircle: Bool = false, placeholder: UIImage? = UIImage()) {

        let finalPath = stringUrl
        let urlStr = (finalPath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url =  URL(string: urlStr!) else {
            print("invalid url --> " + urlStr!)
            return
        }

        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: [.transition(.fade(1))],
                         progressBlock: nil) { (result) in
//            switch result {
//
//            case .success(let value):
//                if roundedCircle {
//                    self.image = value.image.circleMasked
//                }
//            case .failure(let error):
//                print("* setImageWith Error: \(error.localizedDescription)")
//            }
        }
    }
}
