//
//  RegisterViewController.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.


import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import SVProgressHUD

class RegisterViewController: UIViewController {

    let firebaseAU = FirebaseAU()
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        // TODO validate email and password textfield
        if(emailTextfield.text == nil ){
            return;
        }
        if(passwordTextfield.text == nil){
            return;
        }
        SVProgressHUD.show()
        registerOnDB(){[weak self] Bool in
            guard let strongSelf = self else { return }
            if Bool{
                UserDefaults.standard.set(strongSelf.emailTextfield.text, forKey: "email")
                UserDefaults.standard.set(strongSelf.passwordTextfield.text, forKey: "password")
                AppDelegate().HomeVCAsRoot()
            }
        }
        
    }
    
    func registerOnDB(completion:@escaping (Bool) -> Void){
        
        firebaseAU.registerUser(email: emailTextfield.text!, password: passwordTextfield.text!) { (success) in
            if success { completion(success) }
        }
    }
    
    
}
