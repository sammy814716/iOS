//
//  RecordingSoundsViewController.swift
//  pitchperfect
//
//  Created by 邱子誠 on 2017/10/2.
//  Copyright © 2017年 udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var RecordingLabel: UILabel!
    @IBOutlet weak var RecordingButton: UIButton!
    @IBOutlet weak var StopRecordingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        StopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func recordAudio(_ sender: Any) {
    StopRecordingButton.isEnabled = true
    RecordingButton.isEnabled = false
    RecordingLabel.text = "Recording in Progress"
        
        
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
    let recordingName = ("recordedVoice.wav")
    let pathArray = [dirPath, recordingName]
    let filePath = URL.init(fileURLWithPath: pathArray.joined(separator: "/"));
            
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
    
        try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:]);
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
    }

    @IBAction func StopRecording(_ sender: Any) {
    StopRecordingButton.isEnabled = false
    RecordingButton.isEnabled = true
    RecordingLabel.text = "Tap to Record"
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
    }
 
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            print("Reocrding was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundViewController
            let recordAudioURL = sender as! URL
            playSoundsVC.recordAudioURL = recordAudioURL
        }
    }
}
