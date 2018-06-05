//
//  Extensions.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation
import UIKit 
extension String {
    static func random(length: Int) -> String {
        let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersArray = Array(charactersString)
        var string = ""
        for _ in 0..<length {
            string.append(charactersArray[Int(arc4random()) % charactersArray.count])
        }
        return string
    }
    
    func formatDate(_ style: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let mydate = dateFormatter.date(from: self)
        if style == "date" {
            dateFormatter.dateFormat = "dd/MM/yy"
            return dateFormatter.string(from: mydate!)
        }
        dateFormatter.dateFormat = "dd MMM yy, HH:mm"
        return dateFormatter.string(from: mydate!)
    }
}


extension UIColor {
    static var backgroundGray = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    static var paper = UIColor(red: 255/255, green: 213/255, blue: 165/255, alpha: 1)
    //        static var paper = UIColor(red: 231/255, green: 255/255, blue: 211/255, alpha: 1)
    static var paperYellow = UIColor(red: 255/255, green: 246/255, blue: 165/255, alpha: 1)
//    static var blueGray = UIColor(red: 147/255, green: 165/255, blue: 193/255, alpha: 1)
     static var blueGray = UIColor(red: 87/255, green: 133/255, blue: 204/255, alpha: 1)
     static var darkBlue = UIColor(red: 60/255, green: 92/255, blue: 140/255, alpha: 1)
    static var myGray = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
      static var lightGreen = UIColor(red:150/255, green: 183/255, blue: 158/255, alpha: 1)
    static var lightRed = UIColor(red:183/255, green: 150/255, blue: 150/255, alpha: 1)
}




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

