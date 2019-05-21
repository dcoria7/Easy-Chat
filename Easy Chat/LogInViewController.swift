//
//  LogInViewController.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.


import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD


class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    //let firebaseAU = FirebaseAU()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        if(emailTextfield.text == nil ){
            return;
        }
        if(passwordTextfield.text == nil){
            return;
        }
        //TODO: Log in the user
        SVProgressHUD.show()
        self.loginOnDB() {[weak self] Bool in
            guard let strongSelf = self else { return }
            if Bool{
                UserDefaults.standard.set(strongSelf.emailTextfield.text, forKey: "email")
                UserDefaults.standard.set(strongSelf.passwordTextfield.text, forKey: "password")
                
                AppDelegate().HomeVCAsRoot()
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
    func loginOnDB(completion:@escaping (Bool) -> Void){
        
        FirebaseAU.sharedInstanceFirebase.loginDB(email: emailTextfield.text!, password: passwordTextfield.text!) { (success) in
            if success { completion(success) }
        }
        
    }


    
}  
