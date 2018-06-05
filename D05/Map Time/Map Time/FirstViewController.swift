//
//  FirstViewController.swift
//  Map Time
//
//  Created by stephane martins on 6/5/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

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
        print("on est dams le didload du firstviewcontroller")
        print(curtitle, " ", cursubtitle)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func copyData(map: Mapbox)
    {
        print("dans le first view copy data")
        print(map.title, " ", map.subtitle)
          print("on sort dans le first view copy data")
    }
}

