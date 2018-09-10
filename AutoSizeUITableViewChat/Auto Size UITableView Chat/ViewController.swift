//
//  ViewController.swift
//  Auto Size UITableView Chat
//
//  Created by SammyCiou on 2018/9/9.
//  Copyright © 2018年 sammy. All rights reserved.
//

import UIKit

struct chatMessage {
    let text:String
    let isIncoming:Bool
    let date:Date
}


class ViewController: UITableViewController {
    
    fileprivate let cellId = "Cell";
    
    //    let chatMessages = [
    //        chatMessage(text: "Here is my first message", isIncoming: true),
    //        chatMessage(text: "I'm going message another long message here", isIncoming: false),
    //        chatMessage(text: "I'm going message another long message that will word long wrap, I'm going message another long message that will word long wrap, I'm going message another long message that will word long wrap", isIncoming: true),
    //        chatMessage(text: "Yo~ Sammy What's up !", isIncoming: false),
    //        chatMessage(text: "This message should left and with white background", isIncoming: true)
    //    ];
    
    let chatMessages = [
        [
            chatMessage(text: "Here is my first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            chatMessage(text: "I'm going message another long message here", isIncoming: false, date: Date.dateFromCustomString(customString: "08/03/2018"))
        ],
        [
            chatMessage(text: "I'm going message another long message that will word long wrap, I'm going message another long message that will word long wrap, I'm going message another long message that will word long wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "09/03/2018")),
            chatMessage(text: "Yo~ Sammy What's up !", isIncoming: false, date: Date.dateFromCustomString(customString: "09/03/2018"))
        ],
        [
            chatMessage(text: "This message should left and with white background", isIncoming: true, date: Date()),
            chatMessage(text: "This message should right and with darkgray background", isIncoming: true, date: Date())
        ]
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Message";
        navigationController?.navigationBar.prefersLargeTitles = true;
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId);
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count;
    }
    
    class dateHeaderLabel:UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            backgroundColor = .black;
            textColor = .white;
            textAlignment = .center;
            translatesAutoresizingMaskIntoConstraints = false;
            font = UIFont.boldSystemFont(ofSize: 14);
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let orginalContentSize = super.intrinsicContentSize;
            let height = orginalContentSize.height + 12;
            let width = orginalContentSize.width + 20;
            layer.cornerRadius = height / 2;
            layer.masksToBounds = true;
            return CGSize(width: width, height: height);
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSction = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy";
            let dateString = dateFormatter.string(from: firstMessageInSction.date)
            
            let label = dateHeaderLabel();
            label.text = dateString;
            
            let containerView = UIView();
            containerView.addSubview(label);
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            return containerView;
            }
        return nil;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    /*
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     if let firstMessageInSction = chatMessages[section].first{
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "MM/dd/yyyy";
     let dateString = dateFormatter.string(from: firstMessageInSction.date)
     return dateString
     }
     return "section:\(Date())"
     }
     */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell;
        //        cell.textLabel?.text = "Message Here"
        //        cell.textLabel?.numberOfLines = 0;
        //        let ChatMessage = chatMessages[indexPath.row]
        let ChatMessage = chatMessages[indexPath.section][indexPath.row];
        cell.chatMessages = ChatMessage;
        //        cell.messageLabel.text = ChatMessage.text;
        //        cell.isIncoming = ChatMessage.isIncoming;
        return cell;
    }
    
}

extension Date {
    static func dateFromCustomString (customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy";
        return dateFormatter.date(from: customString) ?? Date();
    }
}

