//
//  DetailViewCell.swift
//  json
//
//  Created by 邱子誠 on 2018/3/19.
//  Copyright © 2018年 WorkingCoffe. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel:UILabel!;
    @IBOutlet var valueLabel:UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = UIColor.blue;
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
