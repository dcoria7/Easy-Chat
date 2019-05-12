//
//  AppDelegate.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //TODO: Initialise and Configure your Firebase here:
        FirebaseApp.configure()
        
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        
        if email != nil && password != nil{
            // spinner
            SVProgressHUD.show()
            FirebaseAU().loginDB(email: email!, password: password!) { (success) in
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as! HomeTableViewController
                let nav = UINavigationController(rootViewController: homeViewController)
                self.window!.rootViewController = nav
                
            }
        }
        
        return true
    }

    
    func welcomeVCAsRoot(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "welcomeVC") as! WelcomeViewController
        let nav = UINavigationController(rootViewController: viewController)
        UIApplication.shared.keyWindow?.rootViewController = nav
        
    }
    func HomeVCAsRoot(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as! HomeTableViewController
        let nav = UINavigationController(rootViewController: homeViewController)
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//MARK: - Uncomment this only once you've gotten to Step 14.
    /*
    
let APP_ID = "5H62DKM7JuG6kBBzVICydweQkSQTZD8vsFtoEEew"
let CLIENT_KEY = "UMkw6hwriImwSAEtwxlMbrJXtcccrTR6jdcRS9IN"
    
*/


}

