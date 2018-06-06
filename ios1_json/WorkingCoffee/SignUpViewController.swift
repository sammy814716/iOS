//
//  SignUpViewController.swift
//  ios1
//
//  Created by sunday on 2018/3/25.
//  Copyright © 2018年 sunday. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UITableViewController {
    
    @IBOutlet var mailField:UITextField!;
    @IBOutlet var passwordField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func signUp (_ sender: UIButton){
        
        let mail = mailField.text!;
        let password = passwordField.text!;
        //print("E-mail:\(mail), Password:\(password)")
        
        Auth.auth().createUser(withEmail: mail, password: password) { (user:User?, error:Error?) in
       
            guard let user = user, error == nil else {
                print("註冊失敗，請檢查");
                return;
            }
            self.dismiss(animated: true, completion: nil);
            print("user是\(user.email)");
        }
        
    }

}
