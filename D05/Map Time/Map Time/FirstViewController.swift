//
//  FirstViewController.swift
//  Map Time
//
//  Created by stephane martins on 6/5/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, ChangeMapDataDelegate {

    var curtitle = String()
    var cursubtitle = String()
    var curlatitude = Double()
    var curlongitude = Double()
    
    
    func changeMapData(content: Mapbox) {
        print("ON CHANGE MAP =================>")
        print(content.title)
//        ChangepositionOnMapView(content)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func sayHello() {
        print("Hello!")
    }
    
    func sayGoodbye() {
        print("Goodbye!")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("++++++++++++++Dns le prepare segue de FIRSTVIEEWCONTROLLER===============")
//        if let nav = segue.destination as? UINavigationController, let SecondViewController = nav.topViewController as? SecondViewController {
//            SecondViewController.delegate = self
//        }
//    }


}

