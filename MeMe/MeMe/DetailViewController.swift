//
//  DetailViewController.swift
//  MeMe
//
//  Created by SammyCiou on 2018/5/7.
//  Copyright © 2018年 SammyCiou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView:UIImageView!;
    
    var memes:Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImageView.image = memes.memedImage;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
