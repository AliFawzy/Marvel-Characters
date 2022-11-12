//
//  BaseTableViewCell.swift
//  Marvel
//
//  Created by Mac on 12/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
