//
//  GoogleSignInViewController.swift
//  ios1
//
//  Created by n135 on 2017/11/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class GoogleSignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GoogleSignInViewController:GIDSignInUIDelegate {
    
}
