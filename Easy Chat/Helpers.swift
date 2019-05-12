//
//  Helpers.swift
//  Easy Chat
//
//  Created by Daniel Coria on 5/8/19.
//  Copyright © 2019 Daniel Coria All rights reserved.
//

import Foundation
import UIKit

struct Defaults {
    
    static func clearUserData(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension ChatViewController{
    func hideKeyboardWhenTapedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.messageTableView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
