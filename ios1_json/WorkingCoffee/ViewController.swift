//
//  ViewController.swift
//  WorkingCoffe
//
//  Created by 邱子誠 on 2018/1/4.
//  Copyright © 2018年 WorkingCoffe. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController{
    
    @IBOutlet var tableView:UITableView!;
    
    var allCoffee:[[String:String]] = [];
    var authHandle:AuthStateDidChangeListenerHandle!;
    //var searchController:UISearchController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        authHandle = Auth.auth().addStateDidChangeListener { (auth:Auth, user:User?) in
            if user == nil {
                print("跳轉至登入畫面")
                self.performSegue(withIdentifier: "goSignIn", sender: nil);
            } else {
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.logout(_:)));
                
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white;
                
                //建立下載
                guard let url = URL.init(string: "https://cafenomad.tw/api/v1.2/cafes/taipei") else{
                    print("url有誤")
                    return
                }
                
                let urlSession = URLSession.shared;
                
                let downloadTask = urlSession.downloadTask(with: url) { (url: URL?, urlResponse: URLResponse?, error: Error?) -> Void in
                    
                    guard let url = url else{
                        return;
                    }
                    
                    guard let urlResponse = urlResponse else{
                        return;
                    }
                    
                    guard error == nil else{
                        return;
                    }
                    
                    guard (urlResponse as! HTTPURLResponse).statusCode == 200 else{
                        return;
                    }
                    
                    guard let data = try? Data.init(contentsOf: url) else{
                        return;
                    }
                    
                    //print(String.init(data: data, encoding: String.Encoding.utf8)!);
                    
                    //主執行序進行 json 解析
                    DispatchQueue.main.sync {
                        
                        //let decoder = JSONDecoder();
                        
                        if let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                            
                            //print(dict);
                            
                            for coffee in dict! {
                                var newdict:[String:String] = [:];
                                for (key, value) in coffee {
                                    newdict[key] = "\(value)"
                                }
                                self.allCoffee.append(newdict);
                                /*
                                 print("名稱:\(coffee["name"] ?? "待補" )");
                                 print("時間:\(coffee["open_time"] ?? "待補" )");
                                 print("地點:\(coffee["address"] ?? "待補" )");
                                 print("網址:\(coffee["url"] ?? "待補" )");
                                 print("================================");
                                 */
                            }
                        }
                        self.tableView.reloadData();
                    }
                }
                downloadTask.resume();
            }
            // Do any additional setup after loading the view, typically from a nib.
            let coffeeNamesRef = Database.database().reference(withPath: "WorkingCoffee/Coffees");
            coffeeNamesRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) -> Void in
                if !snapshot.hasChildren() {
                    print("沒有資料");
                    self.uploadToFireBase(CoffeeNamesRef: coffeeNamesRef);
                } else {
                    print("有資料")
                }
            }
        }
    }
    
    func uploadToFireBase(CoffeeNamesRef:DatabaseReference) {
        
        //次執行序執行
        //let queue = DispatchQueue(label: "com.sammy814716")
        
        for coffees in self.allCoffee {
            var newdic:[String:String] = [:];
            for (key, value) in coffees {
                newdic[key] = "\(value)";
                CoffeeNamesRef.child(coffees["name"]!).setValue(newdic);
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goDetail" {
            
            let selectedIndexPath = tableView.indexPathForSelectedRow!;
            let selectedCoffee = allCoffee[selectedIndexPath.row];
            //print("selectedCoffee:\(selectedCoffee)");
            let detailViewController = segue.destination as! DetailViewController;
            detailViewController.allCoffee = selectedCoffee;
            
        }
    }
    
    @objc func logout(_ sender:UIBarButtonItem) {
        
        if (try? Auth.auth().signOut()) == nil{
            print("signOut失敗");
        }
        self.performSegue(withIdentifier: "goSignIn", sender: nil);
    }
    
}


extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return allCoffee.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell;
        let allCoffees = allCoffee[indexPath.row];
        cell.nameLabel.text = allCoffees["name"];
        cell.addressLabel.text = allCoffees["address"];
        return cell;
    }
    
}

extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        let coffee = allCoffee[indexPath.row];
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action:UITableViewRowAction, indexPath:IndexPath) in
            let defaultText = "Just checking in at \(String(describing: coffee["name"]))";
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil);
            self.present(activityController, animated: true, completion: nil);
        }
        shareAction.backgroundColor = UIColor.orange;
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action:UITableViewRowAction, index:IndexPath) in
            self.allCoffee.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .automatic);
        }
        return [shareAction,deleteAction];
    }
    
}
