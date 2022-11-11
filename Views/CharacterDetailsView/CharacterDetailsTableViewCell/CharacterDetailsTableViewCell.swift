//
//  CharacterDetailsTableViewCell.swift
//  Marvel
//
//  Created by Mac on 10/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class CharacterDetailsTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var characterNameLbl: UILabel!
    @IBOutlet weak var characterDescValueLbl: UILabel!
    @IBOutlet weak var descStackView: UIStackView!
    @IBOutlet weak var descView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
