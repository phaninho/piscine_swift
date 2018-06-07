//  ViewController.swift
//  recast
//
//  Created by Stephane MARTINS on 6/6/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {


//    var bot : RecastAIClient?
    

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBAction func askMeBtn(_ sender: Any) {
        if (textField.text != "")
        {
            makeRequest(str: textField.text!)
        }
    }
    
    let bot = RecastAIClient(token : "4402e9599b7a4a7ed200f1d826db9d59", language: "en")
    let forecastClient = DarkSkyClient(apiKey: "a4cfa3b0ee1c496ee301efaae61d7651")
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

   
    func makeRequest(str: String)
    {
        self.bot.textRequest(str, successHandler: recastRequestDone, failureHandle: fail)
    }
    
    func recastRequestDone(_ response : Response)
    {
        if let location = response.get(entity: "location")
        {
            for local in location
            {
                answerLabel.text = local.value.string
            }
            let lng = location["lng"]?.doubleValue
            let lat = location["lat"]?.doubleValue
            if (lng != nil && lat != nil)
            {
                forecastRequest(lat: lat!, lng: lng!)
            }
        }
        
//        for local in location!
//        {
//            print(" ==>> ", local)
//        }
    }
    
    func fail(response: Error) -> Void
    {
        print("Error")
    }
    
    func forecastRequest(lat: Double, lng: Double)
    {
        print("dans le forecast")
        forecastClient.getForecast(latitude: lat, longitude: lng) { result in
            switch result {
            case .success(let currentForecast, let requestMetadata):
                DispatchQueue.main.async{
                    self.answerLabel.text = currentForecast.currently?.summary
                }
            case .failure(let error):
                print("Error")
            }
        }
    }
}

