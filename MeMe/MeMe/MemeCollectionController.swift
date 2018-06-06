//
//  MemeCollectionController.swift
//  MeMe
//
//  Created by SammyCiou on 2018/5/7.
//  Copyright © 2018年 SammyCiou. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class MemeCollectionController: UICollectionViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        self.collectionView!.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
 */
        
        navigationItem.title = "MeMe"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(share(_:)));
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addImage(_:)));

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.collectionView?.reloadData()
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        let meme = memes[indexPath.item];
        print(meme.memedImage)
        cell.memeImageView.image = meme.memedImage;
        // Configure the cell
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goDetail" {
            let selectedIndexPath = collectionView?.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0);
            let selectMeme = memes[selectedIndexPath.item];
            let detailVC = segue.destination as! DetailViewController;
            detailVC.memes = selectMeme
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }

}
