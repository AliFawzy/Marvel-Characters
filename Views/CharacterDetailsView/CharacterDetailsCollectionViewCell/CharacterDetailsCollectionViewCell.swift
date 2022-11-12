//
//  CharacterDetailsCollectionViewCell.swift
//  Marvel
//
//  Created by Mac on 11/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class CharacterDetailsCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!{
        didSet {
            itemImage.layer.cornerRadius = 10
            itemImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
