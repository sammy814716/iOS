//
//  CustomCell.swift
//  json
//
//  Created by 邱子誠 on 2018/3/16.
//  Copyright © 2018年 WorkingCoffe. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var nameLabel:UILabel!;
    @IBOutlet var addressLabel:UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
