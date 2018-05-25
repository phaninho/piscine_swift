//
//  ViewController.swift
//  ex02
//
//  Created by Stephane MARTINS on 5/25/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    var     numOnScreen:Double = 0;
    var     prevNum:Double = 0;
    var     perfCal = false;
    var     operat = 0;
    
    @IBOutlet weak var resLabel: UILabel!
    
    @IBAction func numBtn(_ sender: UIButton)
    {
        if (perfCal == true)
        {
            resLabel.text = String(sender.tag-1)
            numOnScreen = Double(resLabel.text!)!
            perfCal = false
        }
        else
        {
            resLabel.text = resLabel.text! + String(sender.tag-1)
            numOnScreen = Double(resLabel.text!)!
        }
        print("bouton " + String(sender.tag-1))
       
    }
    
    @IBAction func opBtn(_ sender: UIButton)
    {
        if (resLabel.text != "" && sender.tag != 11 && sender.tag != 12 && sender.tag != 17)
        {
//            print("prev ",prevNum, " ", numOnScreen)
            prevNum = numOnScreen;
            if (sender.tag == 13) //div
            {
                resLabel.text = "/"
            }
            else if (sender.tag == 14) // mul
            {
                resLabel.text = "*"
            }
            else if (sender.tag == 15) // sous
            {
                resLabel.text = "-"
            }
            else if (sender.tag == 16) // add
            {
                resLabel.text = "+"
            }
            operat = sender.tag;
            perfCal = true;
        }
        else if (resLabel.text != "" && sender.tag == 17)
        {
            if (operat == 13)
            {
                if (numOnScreen == 0)
                {
                    resLabel.text = "0";
                    numOnScreen = 0;
                    prevNum = 0;
                    operat = 0;
                    perfCal = false;
                }
                else
                {
                    resLabel.text = String(prevNum/numOnScreen)
                }
            }
            else if (operat == 14)
            {
                resLabel.text = String(prevNum*numOnScreen)
            }
            else if (operat == 15)
            {
                resLabel.text = String(prevNum-numOnScreen)
            }
            else if (operat == 16)
            {
                resLabel.text = String(prevNum+numOnScreen)
            }
            print(prevNum, " ", numOnScreen)
            numOnScreen = Double(resLabel.text!)!
        }
        else if (sender.tag == 11)
        {
            resLabel.text = "";
            numOnScreen = 0;
            prevNum = 0;
            operat = 0;
            perfCal = false;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

