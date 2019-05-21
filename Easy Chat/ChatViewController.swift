//
//  ViewController.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD
import ChameleonFramework


class ChatViewController: UIViewController {
    
    var messageArray : [Message] = [Message]()
    //let firebaseAU = FirebaseAU()
    
    var chatName = String()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        
        self.title = chatName
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        self.hideKeyboardWhenTapedAround()

        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMSGOtherCell")
        messageTableView.register(UINib(nibName: "MessageSelfCell", bundle: nil), forCellReuseIdentifier: "customMSGSelfCell")
        configureTableView()
        self.retrieveMessages()
        
        
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = (notification as Notification).userInfo, let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let newHeight: CGFloat
        if #available(iOS 11.0, *) {
            newHeight = value.cgRectValue.height - view.safeAreaInsets.bottom + 50
        } else {
            newHeight = value.cgRectValue.height
        }
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = newHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification){
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
        
    }
    
    func configureTableView(){
        messageTableView.separatorStyle = .none
    }
    
    func retrieveMessages(){
        FirebaseAU.sharedInstanceFirebase.typeChat = chatName
        FirebaseAU.sharedInstanceFirebase.retrieveMessagesFromDB { [weak self] messages in
            guard let strongSelf = self else { return }
            strongSelf.messageArray = messages
            
            strongSelf.configureTableView()
            strongSelf.messageTableView.reloadData()
            
        }
        
    }


}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellOther = tableView.dequeueReusableCell(withIdentifier: "customMSGOtherCell", for: indexPath) as? CustomMessageCell else {
            return CustomMessageCell()
        }
        
        guard let cellSelf = tableView.dequeueReusableCell(withIdentifier: "customMSGSelfCell", for: indexPath) as? CustomMessageCell else {
            return CustomMessageCell()
        }
        if messageArray[indexPath.row].sender == FirebaseAU.sharedInstanceFirebase.getUserEmail(){
            cellSelf.selectionStyle = .none
            cellSelf.message = messageArray[indexPath.row]
            
            return cellSelf
        }else{
            cellOther.selectionStyle = .none
            cellOther.message = messageArray[indexPath.row]
            
            return cellOther
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //messageTextfield.isEnabled = false
        
        let messageDic = ["Sender": FirebaseAU.sharedInstanceFirebase.getUserEmail(),
                          "MessageBody": messageTextfield.text!]
        //self.firebaseAU.typeChat = chatName
        FirebaseAU.sharedInstanceFirebase.typeChat = chatName
        FirebaseAU.sharedInstanceFirebase.sendingMessage(dic: messageDic) { (success) in
            if success{
                //self.messageTextfield.isEnabled = true
                self.messageTextfield.text = ""
            }else{
                
            }
        }
        return true
    }
}

