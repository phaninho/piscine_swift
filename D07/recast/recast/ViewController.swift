//
//  ViewController.swift
//  recast
//
//  Created by Stephane MARTINS on 6/6/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit
import RecastAI

class ViewController: UIViewController {


//    var bot : RecastAIClient?
    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var askButton: UIButton!
    
    @IBOutlet weak var answerLabel: UILabel!
    
     let bot = RecastAIClient(token : "4402e9599b7a4a7ed200f1d826db9d59", language: "english")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.bot = RecastAIClient(token : "4402e9599b7a4a7ed200f1d826db9d59")
//        self.bot = RecastAIClient(token : "4402e9599b7a4a7ed200f1d826db9d59", language: "english")
    }

   
    func makeRequest()
    {
        //Call makeRequest with string parameter to make a text request
        self.bot.textRequest("Paris", successHandler: success, failureHandle: fail)
    }
    
    func success(Response: Response) -> Void
    {
        print("request works")
    }
    
    func fail() -> Void
    {
        print("failed")
    }

}

