//
//  ViewController.swift
//  Retro Calculator
//
//  Created by sunday on 2017/11/19.
//  Copyright © 2017年 sunday. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl:UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multipy = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var runningNumber = "";
    var currentOperation = Operation.Empty;
    var leftValStr = "";
    var rightValStr = "";
    var result = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = "0";
    }
    
    
    @IBAction func numberPressed(sender: UIButton){
        
        runningNumber += "\(sender.tag)";
        outputLbl.text = runningNumber;
    }
    
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMutiplyPressed(_ sender: Any) {
        processOperation(operation: .Multipy)
    }
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber;
                runningNumber = "";
                
                if currentOperation == Operation.Multipy {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
            
                leftValStr = result;
                outputLbl.text = result;
            }
            
            currentOperation = operation
        } else {
            leftValStr = runningNumber;
            runningNumber = "";
            currentOperation = operation;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}
