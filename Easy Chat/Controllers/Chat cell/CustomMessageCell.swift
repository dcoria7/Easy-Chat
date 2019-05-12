//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Angela Yu on 30/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {


    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    
    var message: Message? {
        
        didSet {
            
            OperationQueue.main.addOperation { [unowned self] in
                
                if self.message?.sender == FirebaseAU().getUserEmail(){
                    self.messageBackground.backgroundColor = UIColor.flatSkyBlue()
                    self.senderUsername.textColor = UIColor.clear
                    self.cornerForSelfMessageView()
                    
                }else{
                    self.messageBackground.backgroundColor = UIColor.flatGray()
                    self.senderUsername.textColor = UIColor.flatBlackColorDark()
                    self.cornerForOtherMessageView()
                    
                }
                
                self.messageBackground.translatesAutoresizingMaskIntoConstraints = false
                self.messageBody.text = self.message?.messageBody ?? ""
                self.senderUsername.text = self.message?.sender ?? ""
            }
            
        }
        
    }
    
    
    func cornerForSelfMessageView(){
        self.messageBackground.clipsToBounds = true
        self.messageBackground.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            self.messageBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
            
        } else {
            // Fallback on earlier versions
            self.messageBackground.roundCorners(corners: [.topLeft, .bottomLeft], radius: 15.0)
        }
    }
    
    func cornerForOtherMessageView(){
        self.messageBackground.clipsToBounds = true
        self.messageBackground.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            self.messageBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
            
        } else {
            // Fallback on earlier versions
            self.messageBackground.roundCorners(corners: [.topRight, .bottomRight], radius: 15.0)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    


}

