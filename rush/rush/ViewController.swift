//
//  ViewController.swift
//  rush
//
//  Created by stephane martins on 6/2/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homeImage: UIImageView!
    
    let url_key = "https://simplon.co/wp-content/uploads/2015/03/logo-42.jpg"
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageWithURL(urlString: url_key)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func loadImageWithURL(urlString: String)
    {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data,reponse,error) in
            if error != nil
            {
                print("error")
                return
            }
            DispatchQueue.main.async
            {
                self.homeImage.image = UIImage(data: data!)!
            }
        }).resume()
    }
}

