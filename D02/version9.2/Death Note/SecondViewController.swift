//
//  SecondViewController.swift
//  Death Note
//
//  Created by Stephane MARTINS on 5/29/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

   
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var datePickField: UIDatePicker!
    
    @IBOutlet weak var deathDescriptionField: UITextField!
    
    @IBAction func doneBtn(_ sender: Any) {
        if nameTextField.text != "" && deathDescriptionField.text != ""
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
//            dateTxt.text = dateFormatter.string(from: datePickField.date)
//            self.view.endEditing(true)
            print(Data.deaths.count)
            Data.deaths += [(nameTextField.text!, deathDescriptionField.text!, dateFormatter.string(from: datePickField.date))]
             print(Data.deaths)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
