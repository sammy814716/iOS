//
//  TableViewCell.swift
//  Auto Size UITableView Chat
//
//  Created by SammyCiou on 2018/9/9.
//  Copyright © 2018年 sammy. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel();
    let bubbleBackgroundView = UIView();
    
    var leadingConstraint:NSLayoutConstraint!
    var trailingConstraint:NSLayoutConstraint!
    
    var chatMessages:chatMessage! {
        
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessages.isIncoming ? .white : .darkGray;
            messageLabel.textColor = chatMessages.isIncoming ? .black : .white;
            
            messageLabel.text = chatMessages.text;
            
            if chatMessages.isIncoming {
                trailingConstraint.isActive = false;
                leadingConstraint.isActive = true;
            } else {
                trailingConstraint.isActive = true;
                leadingConstraint.isActive = false;
            }
        }
    }
    
//    var isIncoming:Bool! {
//        didSet {
//            bubbleBackgroundView.backgroundColor = isIncoming ? .white : .darkGray;
//            messageLabel.textColor = isIncoming ? .black : .white;
//        }
//    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear;
        
        bubbleBackgroundView.backgroundColor = UIColor.blue;
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        bubbleBackgroundView.layer.cornerRadius = 5;
        addSubview(bubbleBackgroundView);
        
        //messageLabel.backgroundColor = UIColor.blue;
        //messageLabel.text = "some message over here";
        messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
        messageLabel.numberOfLines = 0;
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(messageLabel);
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor,constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ];
        NSLayoutConstraint.activate(constraints);
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32);
        leadingConstraint.isActive = false;
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32);
        trailingConstraint.isActive = true;
    };
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
