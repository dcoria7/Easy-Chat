//
//  HomeTableViewController.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.

import UIKit
import SVProgressHUD

class HomeTableViewController: UITableViewController {

    //let firebaseAU = FirebaseAU()
    var chatArray = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.dismiss()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        FirebaseAU.sharedInstanceFirebase.getListOfChats(completion: { (valuesArray) in
            print(valuesArray)
            self.chatArray = valuesArray
            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        
        FirebaseAU.sharedInstanceFirebase.logoutDB { (success) in
            if success{
                Defaults.clearUserData(key: "email")
                Defaults.clearUserData(key: "password")
                AppDelegate().welcomeVCAsRoot()
            }
        }
        
    }
    @IBAction func addChannel(_ sender: Any) {
        self.displayMessageWithTextField(title: "Agregar nuevo chat", msg: "Nombre del chat", style: .alert) { (result) in
            if let result = result {
                // create and push to chat
                self.chatArray.append(result)
                let indexPath = IndexPath(item: self.chatArray.count - 1 , section: 0)
                self.performSegue(withIdentifier: "goToChat", sender: indexPath)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToChat", sender: indexPath)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = chatArray[indexPath.row]

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChat"{
            if let destController = segue.destination as? ChatViewController{
                destController.chatName = chatArray[(sender as! NSIndexPath).row]
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
