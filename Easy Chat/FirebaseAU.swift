//
//  FirebaseAuth.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseAU{
    let messageDB = Database.database().reference().child("Messages")
    
    public func loginDB(email: String, password: String, completion:@escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                print(error!)
                completion(false)
            }else{
                print("loggin successful")
                completion(true)
            }
        }
       
    }

    public func registerUser(email: String, password: String, completion:@escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if error != nil{
                print(error!)
                completion(false)
            }else{
                print("Registered")
                completion(true)
            }
        }
    }
    
    public func logoutDB( completion:@escaping(Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch  {
            print("Something went wrong")
            completion(false)
        }
    }
    
    public func getUserEmail() -> String{
        if ((Auth.auth().currentUser) != nil){
            return (Auth.auth().currentUser?.email)!
        }else{
            return ""
        }
        
    }
    
    public func sendingMessage(dic: [String:String], completion: @escaping(Bool) -> Void){
        
        messageDB.childByAutoId().setValue(dic){
            (error, reference) in
            if error != nil{
                completion(false)
                print(error!)
            }else{
                print("message sent")
                completion(true)
            }
        }
    }
    
    public func retrieveMessagesFromDB(completion:@escaping([Message]) -> Void){
        var messageArray = [Message]()
        getMessages { (message) in
            messageArray.append(message)
            completion(messageArray)
        }
        
    }
    
    func getMessages(completion: @escaping(Message) -> Void){
        messageDB.observe(.childAdded) { (snaphot) in
            let messageModel = Message()
            let snapshotValue = snaphot.value as! Dictionary<String,String>
            messageModel.messageBody = snapshotValue["MessageBody"]!
            messageModel.sender = snapshotValue["Sender"]!
            completion(messageModel)
        }
    }
    
}
