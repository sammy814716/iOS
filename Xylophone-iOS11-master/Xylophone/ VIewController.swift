//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var player:AVAudioPlayer?
    let soundArray:[String] = ["note1", "note2", "note3", "note4", "note5", "note6","note7"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        let selectedFileName = soundArray[sender.tag - 1]
        playSound(soundFileName: selectedFileName);
    }
    
    func playSound (soundFileName:String) {
        
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "wav") else { return };
        player = try? AVAudioPlayer(contentsOf: url);
        player?.play();
        
    }
    
  

}

