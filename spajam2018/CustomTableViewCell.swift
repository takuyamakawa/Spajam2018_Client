//
//  CustomTableViewCell.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/12.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var resultNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
