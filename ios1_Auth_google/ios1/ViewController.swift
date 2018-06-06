//
//  ViewController.swift
//  ios1
//
//  Created by mac on 2017/11/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self;
        
        if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: "goSignIn", sender: nil)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sighOut(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth();
        do{
            try firebaseAuth.signOut();
        }catch let signOutError as NSError{
            print("Error signing out: %@", signOutError);
        }
    
        GIDSignIn.sharedInstance().signOut();
        performSegue(withIdentifier: "goSignIn", sender: nil);
        
    }
    
}

extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
            self.dismiss(animated: true, completion: nil);
            self.navigationItem.title = user?.email;
            // User is signed in
            // ...
        }
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    
    }
    
}
