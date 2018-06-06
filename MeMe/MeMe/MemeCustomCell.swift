//
//  MemeCustomCell.swift
//  MeMe
//
//  Created by SammyCiou on 2018/5/7.
//  Copyright © 2018年 SammyCiou. All rights reserved.
//

import UIKit

class MemeCustomCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView:UIImageView!
    @IBOutlet weak var topTextField:UITextField!
    @IBOutlet weak var buttomTextField:UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
