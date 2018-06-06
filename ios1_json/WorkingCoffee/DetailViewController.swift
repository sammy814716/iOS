//
//  DetailViewController.swift
//  json
//
//  Created by 邱子誠 on 2018/3/16.
//  Copyright © 2018年 WorkingCoffe. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UITableViewController {
    
    var allCoffee:[String:String] = [:];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.logout(_:)));
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white;
        
        print("DetailViewllCoffee:\(allCoffee)");
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func logout(_ sender:UIBarButtonItem) {
        
        if (try? Auth.auth().signOut()) == nil{
            print("signOut失敗");
        }
        
        self.performSegue(withIdentifier: "goSignIn", sender: nil);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailViewCell;
        
        cell.backgroundColor = UIColor.clear;
        switch indexPath.row{
            
        case 0:
            cell.nameLabel.text = "名稱";
            cell.valueLabel.text = allCoffee["name"];
        case 1:
            cell.nameLabel.text = "地址";
            cell.valueLabel.text = allCoffee["address"];
        case 2:
            cell.nameLabel.text = "時間";
            cell.valueLabel.text = allCoffee["open_time"];
        case 3:
            cell.nameLabel.text = "網址";
            cell.valueLabel.text = allCoffee["url"];
            
        default:
            cell.nameLabel.text = "";
            cell.valueLabel.text = "";
        }
        
        return cell;
    }
    
}
