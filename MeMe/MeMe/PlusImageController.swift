//
//  ViewController.swift
//  MeMe
//
//  Created by SammyCiou on 2018/5/5.
//  Copyright © 2018年 SammyCiou. All rights reserved.
//

import UIKit

class PlusImageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraButton:UIBarButtonItem!
    @IBOutlet weak var libraryButton:UIBarButtonItem!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var topTextField:UITextField!
    @IBOutlet weak var buttomTextField:UITextField!
    
    var memeImage:UIImage?
    
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.orange,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: 5.0];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Choose Photo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(save(_:)));
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(share(_:)));
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        imageView.backgroundColor = .black;
        topTextField.text = ""
        buttomTextField.text = ""
        topTextField.defaultTextAttributes = memeTextAttributes;
        buttomTextField.defaultTextAttributes = memeTextAttributes;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera);
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        unsubscribeFromKeyboardNotifications();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageView.image = image
        }
        
        dismiss(animated: true, completion: nil);
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil);
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        let height = view.frame.size.height
        view.frame.size.height = (height - getKeyboardHeight(notification));
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.size.height = UIWindow().frame.size.height;
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func save(_: UIBarButtonItem) {
        // Create the meme
        
        let meme = Meme(topText: topTextField.text!, bottomText: buttomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func share(_: UIBarButtonItem) {
        // Create the meme
        
        memeImage = generateMemedImage();
        let activityController = UIActivityViewController(activityItems: [memeImage ?? "傳送失敗"], applicationActivities: nil);
        present(activityController, animated: true, completion: nil);
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        memeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memeImage!
    }
    
}

extension PlusImageController: UITextViewDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event);
        self.view.endEditing(true);
    }
    
}

