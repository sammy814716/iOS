//
//  MemeTableController.swift
//  MeMe
//
//  Created by SammyCiou on 2018/5/7.
//  Copyright © 2018年 SammyCiou. All rights reserved.
//

import UIKit

class MemeTableController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MeMe"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(share(_:)));
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addImage(_:)));
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        print("有執行viewWillAppear")
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addImage(_: UIBarButtonItem) {
        
        let plusImageController =  self.storyboard!.instantiateViewController(withIdentifier: "plusImageController") as! PlusImageController
        
        let navController = UINavigationController(rootViewController: plusImageController)
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc func share(_: UIBarButtonItem) {
        print("分享中")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemeCustomCell
        
        let meme = self.memes[indexPath.row];
        cell.memeImageView.image = meme.memedImage
        cell.topTextField.text = meme.topText
        cell.buttomTextField.text = meme.bottomText;
        
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goDetail" {
            
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            let selectMeme = memes[selectedIndexPath.row]
            let detailVC = segue.destination as! DetailViewController;
            detailVC.memes = selectMeme
        }
    }
    
}
