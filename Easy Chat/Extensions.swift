//
//  Extensions.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/22/19.
//  Copyright © 2019 DC. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func displaySimpleMessage(title : String?, msg : String,
                    style: UIAlertController.Style = .alert) {
       
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: style)
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func displayMessageWithTextField(title: String?, msg: String, style: UIAlertController.Style, completion: @escaping (String?)->()){
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: style)
        
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ -> Void in
            let chatName = ac.textFields![0]
            // do something interesting with "answer" here
            completion(chatName.text)
        }
        ac.addAction(UIAlertAction.init(title: "Cancel",
                                        style: .cancel, handler: nil))
        
        ac.addAction(submitAction)
        
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
}
